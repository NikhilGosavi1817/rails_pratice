require 'rails_helper'

RSpec.describe User, type: :request do
    describe 'GET /api/v1/users' do

        it 'returns list of all users' do
            get '/api/v1/users'
            expect(response).to have_http_status(:ok)
        end

        it 'returns a empty list of users' do
            get '/api/v1/users'
            json_response=JSON.parse(response.body)
            expect(json_response).to be_empty
        end

    end
    

end