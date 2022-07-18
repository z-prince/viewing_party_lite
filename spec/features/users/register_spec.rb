require 'rails_helper'

RSpec.describe 'user registration page' do
  it 'has a form that allows a user to input name and email' do
    visit '/register'

    fill_in('Name', with: 'Sylvester Tommy')
    fill_in('Email', with: 'birdsarentreal@gmail.com')
    fill_in('Password', with: 'hellcats420')
    fill_in('Password Confirmation', with: 'hellcats420')

    click_on('Register')

    expect(current_path).to eq("/users/#{User.last.id}")
  end

  it 'returns a user to the register page if they miss forms' do
    visit '/register'

    fill_in('Name', with: 'Sylvester Tommy')
    fill_in('Password', with: 'hellcats420')
    fill_in('Password Confirmation', with: 'hellcats420')

    click_on('Register')

    expect(current_path).to eq('/register')

    expect(page).to have_content('Missing Required Fields')
  end
end
