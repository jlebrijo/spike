class AuthenticationController < ApplicationController
  include ApipieDefinitions

  api :post, '/auth/sign_in', 'Creates a new session'
  param :password, String, 'User password', required: true
  param :email, String, 'User Email', required: true
  returns desc: "Login successful" do
    property :id, String
    property :email, String
    property :first_name, String
  end
  description <<-EOS
    # Login

    Sign in with email/password and recover the authentication headers
    that should be used in all the following authenticated
    connections.

    Auth headers returned example:

        {
           "access-token"=>"abcd1dMVlvW2BT67xIAS_A",
           "token-type"=>"Bearer",
           "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w",
           "expiry"=>"1519086891",
           "uid"=>"darnell@konopelski.info"
        }

    Auth headers needed in authenticated endpoints:

        {
           "access-token"=>"abcd1dMVlvW2BT67xIAS_A",
           "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w",
           "uid"=>"darnell@konopelski.info"
        }

  EOS
  def create; end

  api :get, '/auth/confirmation', 'Confirms user email'
  param :confirmation_token, String, 'Token', required: true
  param :redirect_url, String, 'Redirection after confirmation', required: true
  def show; end

  api :post, '/auth/passwords', 'Sends reset password email'
  param :email, String, 'User email', required: true
  param :redirect_url, String, 'URL to password_reset form in email sent. Frontend will get auth_headers in URL params', required: true
  def create_email; end

  api :PUT, '/auth/passwords', 'Modifies Password. Needs auth_headers coming from redirect URL'
  param :password, String, 'New password', required: true
  param :password_confirmation, String, 'Password confirmation', required: true
  param_group :auth_headers
  def update; end
end
