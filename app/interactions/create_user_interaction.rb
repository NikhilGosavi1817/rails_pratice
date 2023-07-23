# require 'active_interaction'

class CreateUserInteraction < ActiveInteraction::Base

    string :first_name
    string :last_name
    integer :age
    string :date_of_birth
    string :email
    string :password

    def execute
        User.create!(inputs)
    end

end