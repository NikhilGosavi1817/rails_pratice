require 'rails_helper'

RSpec.describe User, type: :feature do

    scenario "user signs up with valid credentials" do
        user=build(:user)
        user.password_confirmation = user.password
        visit new_user_registration_path
        fill_in 'First Name', with: user.first_name
        fill_in 'Last Name', with: user.last_name
        fill_in 'Age', with: user.age
        fill_in 'Date of birth', with: user.date_of_birth
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
        click_button "Sign up"
        expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    scenario "user signs up with invalid credentials" do
        user=build(:user)
        visit new_user_registration_path
        fill_in 'First Name', with: user.first_name
        fill_in 'Last Name', with: user.last_name
        fill_in 'Age', with: user.age
        fill_in 'Date of birth', with: user.date_of_birth
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
        click_button "Sign up"
        expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "user signs up with invalid credentials" do
        user=build(:user, first_name: "")
        user.password_confirmation=user.password
        visit new_user_registration_path
        fill_in 'First Name', with: user.first_name
        fill_in 'Last Name', with: user.last_name
        fill_in 'Age', with: user.age
        fill_in 'Date of birth', with: user.date_of_birth
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
        click_button "Sign up"
        expect(page).to have_content("can't be blank")
    end

    scenario "user signs up with invalid credentials" do
        user=build(:user, last_name: "")
        user.password_confirmation=user.password
        visit new_user_registration_path
        fill_in 'First Name', with: user.first_name
        fill_in 'Last Name', with: user.last_name
        fill_in 'Age', with: user.age
        fill_in 'Date of birth', with: user.date_of_birth
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
        click_button "Sign up"
        expect(page).to have_content("can't be blank")
    end

    scenario "user signs up with invalid credentials" do
        user=build(:user, age: 2)
        user.password_confirmation=user.password
        visit new_user_registration_path
        fill_in 'First Name', with: user.first_name
        fill_in 'Last Name', with: user.last_name
        fill_in 'Age', with: user.age
        fill_in 'Date of birth', with: user.date_of_birth
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
        click_button "Sign up"
        expect(page).to have_content("must be greater than or equal to 18")
    end

    scenario "user signs up with invalid credentials" do
        futur_date=Faker::Date.forward(days: 30)
        user=build(:user, date_of_birth: futur_date)
        user.password_confirmation=user.password
        visit new_user_registration_path
        fill_in 'First Name', with: user.first_name
        fill_in 'Last Name', with: user.last_name
        fill_in 'Age', with: user.age
        fill_in 'Date of birth', with: user.date_of_birth
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
        click_button "Sign up"
        expect(page).to have_content("cannot be in future")
    end

    scenario "user signs up with invalid credentials" do
        existing_email="nikhil@gmail.com"
        create(:user, email: existing_email)
        user=build(:user, email: existing_email)
        user.password_confirmation=user.password
        visit new_user_registration_path
        fill_in 'First Name', with: user.first_name
        fill_in 'Last Name', with: user.last_name
        fill_in 'Age', with: user.age
        fill_in 'Date of birth', with: user.date_of_birth
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
        click_button "Sign up"
        expect(page).to have_content("has already been taken")
    end

    scenario "user signs up with invalid credentials" do
        user=build(:user, email: "nikhilgmail.com")
        user.password_confirmation=user.password
        visit new_user_registration_path
        fill_in 'First Name', with: user.first_name
        fill_in 'Last Name', with: user.last_name
        fill_in 'Age', with: user.age
        fill_in 'Date of birth', with: user.date_of_birth
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
        click_button "Sign up"
        expect(page).to have_content("is invalid")
    end

end