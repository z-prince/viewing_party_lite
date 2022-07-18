require 'rails_helper'

RSpec.describe 'User registration form' do
  it 'creates new user' do
    visit '/register'

    email = 'happy@me.com'
    password = 'test'
    name = 'Sandy Sarco'

    fill_in :user_email, with: email
    fill_in :user_name, with: name
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on 'Create User'

    expect(page).to have_content("Welcome, #{email}!")
  end
end
