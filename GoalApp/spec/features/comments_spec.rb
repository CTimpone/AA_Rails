require "rails_helper"


feature "allows users to make comments on goals" do

  before (:each) do
    visit new_user_url
    fill_in 'Username', with: "username"
    fill_in 'Password', with: "password"
    click_on "Create User"

    click_on "Create Goal"
    fill_in 'Body', :with=>"Test Goal"
    choose('Private')
    choose('In Progress')
    click_on "Submit"
  end

  it "displays add comment on goal show page" do
    expect(page).to have_content "Add Comment"
  end

  it "validates presence of comment body" do
    click_on "Add Comment"
    click_on "Create Comment"
    expect(page).to have_content "Body can't be blank"
  end

  it "redirects user to add comment page" do
    click_on "Add Comment"
    expect(page).to have_content "Test Goal"
    expect(page).to have_content "Add Comment"
    expect(page).to have_content "Create Comment"
  end

  it "redirects user to goal show page after posting comment" do
    click_on "Add Comment"
    fill_in 'Body', with: "Comment 1"
    click_on "Create Comment"
    expect(page).to have_content "Goals Index"
    expect(page).to have_content "Comment 1"
  end

  it "displays multiple comments" do
    click_on "Add Comment"
    fill_in 'Body', with: "Comment 1"
    click_on "Create Comment"

    click_on "Add Comment"
    fill_in 'Body', with: "Comment 2"
    click_on "Create Comment"

    click_on "Add Comment"
    fill_in 'Body', with: "Comment 3"
    click_on "Create Comment"

    expect(page).to have_content "Comment 1"
    expect(page).to have_content "Comment 2"
    expect(page).to have_content "Comment 3"
  end

end

feature "allows users to make comments on users" do

    before (:each) do
      visit new_user_url
      fill_in 'Username', with: "username"
      fill_in 'Password', with: "password"
      click_on "Create User"
    end

    it "displays add comment on user show page" do
      expect(page).to have_content "Add Comment"
    end

    it "validates presence of comment body" do
      click_on "Add Comment"
      click_on "Create Comment"
      expect(page).to have_content "Body can't be blank"
    end

    it "redirects user to add comment page" do
      click_on "Add Comment"
      expect(page).to have_content "username"
      expect(page).to have_content "Add Comment"
      expect(page).to have_content "Create Comment"
    end

    it "redirects user to user show page after posting comment" do
      p
      click_on "Add Comment"
      fill_in 'Body', with: "Comment 1"
      click_on "Create Comment"
      expect(page).to have_content "username"
      expect(page).to have_content "Comment 1"
    end

    it "displays multiple comments" do
      click_on "Add Comment"
      fill_in 'Body', with: "Comment 1"
      click_on "Create Comment"

      click_on "Add Comment"
      fill_in 'Body', with: "Comment 2"
      click_on "Create Comment"

      click_on "Add Comment"
      fill_in 'Body', with: "Comment 3"
      click_on "Create Comment"

      expect(page).to have_content "Comment 1"
      expect(page).to have_content "Comment 2"
      expect(page).to have_content "Comment 3"
    end

end
