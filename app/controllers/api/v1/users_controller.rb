require "#{Rails.root}/app/interactions/create_user_interaction"
require "#{Rails.root}/app/interactions/update_user_interaction"
class Api::V1::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    api :GET, 'v1/users', 'Get a list of users'
    param :user, Hash, desc: 'User parameters' do
        param :id, Integer, desc: 'Id', required: true
        param :first_name, String, desc: 'First Name', required: true
        param :last_name, String, desc: 'Last Name', required: true
        param :email, String, desc: 'Email', required: true
        param :created_at, DateTime, desc: 'Created at', required: true
    end
    def index
        users=User.all
        render json: users
    end

    api :POST, 'v1/users', 'Create a new user'
    param :user, Hash, desc: 'User parameters' do
        param :first_name, String, desc: 'First Name', required: true
        param :last_name, String, desc: 'Last Name', required: true
        param :age, Integer, desc: 'Age', required: true
        param :date_of_birth, Date, desc: 'Date of Birth', required: true
        param :email, String, desc: 'Email', required: true
        param :password, String, desc: 'Password', required: true
    end
    def create
        users=CreateUserInteraction.run(params)
        if users.valid?
            render json: users.result, status: :created
        end
    end


    api :GET, 'v1/users', 'Get a list of users'
    param :user, Hash, desc: 'User parameters' do
        param :id, Integer, desc: 'Id', required: true
        param :first_name, String, desc: 'First Name', required: true
        param :last_name, String, desc: 'Last Name', required: true
        param :email, String, desc: 'Email', required: true
        param :created_at, DateTime, desc: 'Created at', required: true
    end
    def show
        user=User.find(params[:id])
        render json: user,status: :ok
    end

    api :PUT, 'v1/users', 'Update a new user'
    # param :user, Hash, desc: 'User parameters' do
    #     param :first_name, String, desc: 'First Name', required: true
    #     param :last_name, String, desc: 'Last Name', required: true
    #     param :age, Integer, desc: 'Age', required: true
    #     param :date_of_birth, Date, desc: 'Date of Birth', required: true
    #     param :email, String, desc: 'Email', required: true
    #     param :password, String, desc: 'Password', required: true
    # end
    param :id, :number, required: true
      param :user, Hash, desc: 'User object' do
        param :name, String, desc: 'Name of the user', required: false
        param :email, String, desc: 'Email of the user', required: false
        param :password, String, desc: 'Password of the user', required: false
      end
      returns :code => 200, :desc => 'User updated successfully'
      returns :code => 422, :desc => 'Unprocessable Entity'
    def update
        user=User.find(params[:id])
        # users = UpdateUserInteraction.run(user: user, **params[:user])
        users=UpdateUserInteraction.run(user: user, first_name: params[:user][:first_name], last_name: params[:user][:last_name], age: params[:user][:age], date_of_birth: params[:user][:date_of_birth], email: params[:user][:email], password: params[:user][:password])
        # inputs={user: find_user!}.reverse_merge(params[:user])
        # user=UpdateUserInteraction.run(inputs)
        # users=CreateUserInteraction.run(params)
        if users.valid?
            render json: users.result, status: :ok
            else
          render json: { errors: users.errors.full_messages }, status: :unprocessable_entity
        end
    end
end
