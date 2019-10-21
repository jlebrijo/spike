# include ActionController::RespondWith

# The authentication header looks something like this:
# {
#    "access-token"=>"abcd1dMVlvW2BT67xIAS_A",
#    "token-type"=>"Bearer",
#    "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w",
#    "expiry"=>"1519086891",
#    "uid"=>"darnell@konopelski.info"
#  }

describe 'Sessions', type: :request do
  let(:user) { create :user }
  before(:each) do
    user.confirm
  end

  describe 'POST /auth/sign_in' do
    describe 'when correct password' do
      it 'responds 200' do
        login user

        expect(response).to have_http_status :ok
      end

      it 'responds authentication headers' do
        login user

        expect(response).to have_header('access-token')
        expect(response).to have_header('token-type')
        expect(response).to have_header('client')
        expect(response).to have_header('expiry')
        expect(response).to have_header('uid')
      end
    end

  end

end