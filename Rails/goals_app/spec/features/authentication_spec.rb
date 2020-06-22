
require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Create a User'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Enter email', with: 'testingusername'
      fill_in 'Enter Password', with: 'testingpassword'
      click_on 'Submit'
    end
    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content 'testingusername'
    end

  end
end

feature 'logging in' do
  before(:each) do
      visit new_user_url
      fill_in 'Enter email', with: 'testingusername'
      fill_in 'Enter Password', with: 'testingpassword'
      click_on 'Submit'
      click_on 'Logout'
  end
  scenario 'shows username on the homepage after login' do
      visit new_session_url
      fill_in 'Enter email', with: 'testingusername'
      fill_in 'Enter Password', with: 'testingpassword'
      click_on 'Log In'
      expect(page).to have_content 'testingusername'
  end

end

feature 'logging out' do
  before(:each) do
    visit new_user_url
    fill_in 'Enter email', with: 'testingusername'
    fill_in 'Enter Password', with: 'testingpassword'
    click_on 'Submit'
    click_on 'Logout'
  end
  scenario 'begins with a logged out state' do
      visit new_session_url
      fill_in 'Enter email', with: 'testingusername'
      fill_in 'Enter Password', with: 'testingpassword'
      click_on 'Log In'
      click_on 'Logout'
      expect(page).not_to have_content 'testingusername'

  end

  scenario 'doesn\'t show username on the homepage after logout' do
      visit new_session_url
      fill_in 'Enter email', with: 'testingusername'
      fill_in 'Enter Password', with: 'testingpassword'
      click_on 'Log In'
      click_on 'Logout'
      expect(page).not_to have_content 'testingusername'
  end

end