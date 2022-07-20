require 'rails_helper'

RSpec.describe 'User login page' do
  it 'logs in an existing user' do
    user = User.create(name: 'Sandy', email: 'floop@aol.com', password: 'ghostbuster33')

    visit root_path

    click_on('Log In')

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq("/users/#{user.id}")
  end

  it 'redirects false credentials to login page' do
    user = User.create(name: 'Sandy', email: 'floop@aol.com', password: 'ghostbuster33')

    visit root_path

    click_on('Log In')

    fill_in :email, with: user.email
    fill_in :password, with: 'coolguy49'

    click_on 'Log In'

    expect(current_path).to eq('/login')
    expect(page).to have_content('Wrong email or password')

    visit root_path

    click_on('Log In')

    fill_in :email, with: 'strongestmanalive@aol.com'
    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq('/login')
    expect(page).to have_content('Wrong email or password')
  end

  it 'can create and log in a user' do
    user = User.create(name: 'Sandy', email: 'floop@aol.com', password: 'ghostbuster33')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content('Sandy Sarco')
  end

  it 'can log out a user' do
    # user = User.create(name: 'Sandy', email: 'floop@aol.com', password: 'ghostbuster33')
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user = User.create(name: 'Sandy', email: 'floop@aol.com', password: 'ghostbuster33')

    visit root_path

    click_on('Login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Log In'

    visit root_path

    expect(page).to_not have_content('Login')
    expect(page).to_not have_content('Register as a User')
    click_on('Logout')

    expect(current_path).to eq(root_path)

    expect(page).to have_content('Login')
    expect(page).to have_content('Register as a User')
    expect(page).to_not have_content('Logout')
  end
end
