require 'rails_helper'

RSpec.describe 'User registration form' do
  it 'creates new user' do
    visit '/register'

    email = 'happy@me.com'
    password = 'test'
    name = 'Sandy Sarco'

    fill_in :email, with: email
    fill_in :name, with: name
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on 'Create User'

    user = User.find_by(email: 'happy@me.com')
    # expect(user.name).to eq(name)
    # expect(user.email).to eq(email)
    # expect(user.password).to_not eq(password)

    expect(current_path).to eq("/users/#{user.id}")
  end

  it 'returns a user to the register page if they miss forms' do
    visit '/register'

    email = 'happy@me.com'
    password = 'test'
    name = 'Sandy Sarco'

    fill_in :name, with: name
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on('Create User')

    expect(current_path).to eq('/register')

    expect(page).to have_content('Missing Required Fields')

    visit '/register'

    email = 'happy@me.com'
    password = 'test'
    name = 'Sandy Sarco'

    fill_in :email, with: email
    fill_in :name, with: name
    fill_in :password_confirmation, with: password

    click_on('Create User')

    expect(current_path).to eq('/register')

    expect(page).to have_content('Password and confirmation do not match!')
  end

  it 'returns a user to the register page if their password confirmation does not match their password forms' do
    visit '/register'

    email = 'happy@me.com'
    password = 'test'
    name = 'Sandy Sarco'

    fill_in :email, with: email
    fill_in :name, with: name
    fill_in :password, with: password
    fill_in :password_confirmation, with: 'Whoopsie'

    click_on('Create User')
    require 'pry'
    binding.pry
    expect(current_path).to eq('/register')

    expect(page).to have_content('Password and confirmation do not match!')
  end
end
