require "rails_helper"

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
    expect(page).to have_content "Create User"

  end

  feature "signing up a user" do
    before (:each) do
      visit new_user_url
    end

    it "validates presence of username" do
      fill_in 'Password', :with=>"password"
      click_on "Create User"
      expect(page).to have_content "Username can't be blank"
    end

    it "validates length of password" do
      fill_in 'Username', with: "username"
      fill_in 'Password', with: "four"
      click_on "Create User"
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end

    it "shows username on the homepage after signup" do
      fill_in 'Username', with: "username"
      fill_in 'Password', with: "password"
      click_on "Create User"
      expect(page).to have_content "username"
    end

  end

end

feature "logging in" do

  it "has a sign-in page" do
    visit new_session_url
    expect(page).to have_content "Sign In"
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
    expect(page).to have_content "Log In"

  end

  feature "signing in a user" do
    before (:each) do
      visit new_user_url
      fill_in 'Username', with: "username"
      fill_in 'Password', with: "password"
      click_on "Create User"
      visit new_session_url
    end

    it "validates existance of user" do
      fill_in 'Password', :with=>"password"
      click_on "Log In"
      expect(page).to have_content "Invalid username/password combination."
    end

    it "shows username on the homepage after signup" do
      fill_in 'Username', with: "username"
      fill_in 'Password', with: "password"
      click_on "Log In"
      expect(page).to have_content "username"
    end
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit new_session_url
    expect(page).to have_content "Sign In"
    expect(page).to have_content "Sign Up"
  end

  it "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in 'Username', with: "username"
    fill_in 'Password', with: "password"
    click_on "Create User"
    click_on "Sign Out"
    visit user_url(1)
    expect(page).to have_no_content "username"

  end

end
