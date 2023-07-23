class UpdateUserInteraction < ActiveInteraction::Base
    object :user
    hash :user_params, strip: false do
        string :first_name, default: nil
        string :last_name, default: nil
        integer :age, default: nil
        string :date_of_birth, default: nil
        string :email, default: nil
        string :password, default: nil
    end
    # string :first_name, :last_name, :date_of_birth, :email, :password, default: nil
    # integer :age, default: nil
    def execute
        user.update(user_attributes)
        # user.first_name = first_name if first_name.present?
        # user.last_name = last_name if first_name.present?
    end

end