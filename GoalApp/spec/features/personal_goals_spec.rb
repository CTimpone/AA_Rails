require "rails_helper"

feature "can create goals" do

  before (:each) do
    visit new_user_url
    fill_in 'Username', with: "username"
    fill_in 'Password', with: "password"
    click_on "Create User"
  end

  it "has option to create goal" do
    expect(page).to have_content ("Create Goal")
  end

  it "visits new goal page" do
    click_on "Create Goal"

    expect(page).to have_content ("Create Goal")
    expect(page).to have_content ("Body")
    expect(page).to have_content ("Public")
    expect(page).to have_content ("Private")
    expect(page).to have_content ("Completed")
    expect(page).to have_content ("In Progress")
  end

  it "validates presence of parameters" do
    click_on "Create Goal"
    click_on "Submit"
    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "You must select public or private"
    expect(page).to have_content "You must select completed or in progress"
  end

  it "goes to show page for goal after submission" do
    click_on "Create Goal"
    fill_in 'Body', :with=>"Test Goal"
    choose('Public')
    choose('In Progress')
    click_on "Submit"
    expect(page).to have_content ("Test Goal")
    expect(page).to have_content ("username")
    expect(page).to have_content ("Public")
    expect(page).to have_content ("In Progress")
  end

end

feature "Can Edit Goals" do

  before (:each) do
    visit new_user_url
    fill_in 'Username', with: "username"
    fill_in 'Password', with: "password"
    click_on "Create User"
    click_on "Create Goal"
    fill_in 'Body', :with=>"Test Goal"
    choose('Public')
    choose('In Progress')
    click_on "Submit"
  end

  it "displays Edit Goal on 'show' page" do
    expect(page).to have_content ("Edit Goal")
  end

  it "visits edit goal page" do
    click_on "Edit Goal"
    expect(page).to have_content ("Edit Goal")
    expect(page).to have_content ("Body")
    expect(page).to have_content ("Public")
    expect(page).to have_content ("Private")
    expect(page).to have_content ("Completed")
    expect(page).to have_content ("In Progress")
  end

  it "successfully updates a goal" do
    click_on "Edit Goal"
    choose('Completed')
    click_on "Submit"
    expect(page).to have_content ("Completed")
  end

  it "doesn't allow empty body" do
    click_on "Edit Goal"
    fill_in 'Body', :with=>""
    click_on "Submit"
    expect(page).to have_content ("Body can't be blank")
  end

  it "does not give option to Edit when logged in as other user" do
    click_on "Sign Out"
    visit new_user_url
    fill_in 'Username', with: "user2"
    fill_in 'Password', with: "password"
    click_on "Create User"
    visit personal_goals_url
    click_on "Test Goal"
    expect(page).to have_no_content ("Edit Goal")
  end

end

feature "public goals index" do

  before (:each) do
    visit new_user_url
    fill_in 'Username', with: "username"
    fill_in 'Password', with: "password"
    click_on "Create User"
    click_on "Create Goal"
    fill_in 'Body', :with=>"Test Goal"
    choose('Public')
    choose('In Progress')
    click_on "Submit"
  end

  it "has link to return to index" do
    expect(page).to have_content ("Goals Index")
  end

  it "has link to create goal" do
    click_on "Goals Index"
    expect(page).to have_content ("Create Goal")
  end

  it "lists public goals" do
    click_on "Goals Index"
    click_on "Create Goal"
    fill_in 'Body', :with=>"Test Goal 2"
    choose('Public')
    choose('In Progress')
    click_on "Submit"
    click_on "Goals Index"
    click_on "Create Goal"
    fill_in 'Body', :with=>"Test Goal 3"
    choose('Private')
    choose('In Progress')
    click_on "Submit"
    click_on "Goals Index"

    expect(page).to have_content ("Test Goal")
    expect(page).to have_content ("Test Goal 2")
    expect(page).to have_no_content ("Test Goal 3")
  end

end

feature "Can Delete Personal Goals" do

  before (:each) do
    visit new_user_url
    fill_in 'Username', with: "username"
    fill_in 'Password', with: "password"
    click_on "Create User"
    click_on "Create Goal"
    fill_in 'Body', :with=>"Test Goal"
    choose('Public')
    choose('In Progress')
    click_on "Submit"
  end

  it "displays Delete Goal on 'show' page when owner" do
    expect(page).to have_content ("Delete Goal")
  end

  it "does not give option to Delete when logged in as other user" do
    click_on "Sign Out"
    visit new_user_url
    fill_in 'Username', with: "user2"
    fill_in 'Password', with: "password"
    click_on "Create User"
    visit personal_goals_url
    click_on "Test Goal"
    expect(page).to have_no_content ("Delete Goal")
  end

  it "removes goal from index" do
    click_on "Delete Goal"
    expect(page).to have_content "Goals Index"
    expect(page).to have_no_content ("Test Goal")
  end

end

feature "Maintains Privacy" do

  before(:each) do
    visit new_user_url
    fill_in 'Username', with: "username"
    fill_in 'Password', with: "password"
    click_on "Create User"
    click_on "Create Goal"
    fill_in 'Body', :with=>"Test Goal"
    choose('Private')
    choose('In Progress')
    click_on "Submit"
    click_on "Sign Out"

    visit new_user_url
    fill_in 'Username', with: "user2"
    fill_in 'Password', with: "password"
    click_on "Create User"
  end

  it "doesnt allow users to view other users private goals" do
    visit personal_goal_url(PersonalGoal.last)
    expect(page).to have_no_content("Test Goal")
    expect(page).to have_content("Goals Index")
  end

  it "doesnt allow users to view other users show page" do
    visit user_url(User.all[-2])
    expect(page).to have_no_content("Test Goal")
    expect(page).to have_content("username")
  end

end
