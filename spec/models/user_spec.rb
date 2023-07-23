require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is vaild with all correct attributes" do
    user=build(:user)
    expect(user).to be_valid
  end

  it "is invaild with blank first name" do
    user=build(:user, first_name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invlaid with blank last_name" do
    user=build(:user, last_name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without date" do
    user=build(:user, date_of_birth: nil)
    expect(user).to_not be_valid
    expect(user.errors[:date_of_birth]).to include ("can't be blank")
  end

  it "is invalid with invalid email" do
    user=build(:user, email: "nikhil@gmailcom")
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include ("is invalid")
  end

  it "is invalid with short password" do
    user=build(:user, password: "ni")
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include ("is too short (minimum is 6 characters)")
  end

  it "is invalid with password confirmation doesn't matches" do
    user=build(:user, password: "nikhil18", password_confirmation: "nikhil")
    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to include ("doesn't match Password")
  end

  it "is invalid with invalid email" do
    existing_user=create(:user, email: "nikhil@gmail.com")
    user=build(:user, email: "nikhil@gmail.com")
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include ("has already been taken")
  end
end
