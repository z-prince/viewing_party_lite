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

    user = User.find_by(email: 'happy@me.com')

    expect(user.name).to eq(name)
    expect(user.email).to eq(email)
    expect(user.password).to_not eq(password)

    expect(current_path).to eq("users/#{user.id}")
  end
end
