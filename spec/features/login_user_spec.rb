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
end
