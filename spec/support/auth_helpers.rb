def login(user)
  post auth_user_session_path,
       params:  { email: user.email,
                  password: user.password }.to_json,
       headers: { 'CONTENT_TYPE' => 'application/json',
                  'ACCEPT' => 'application/json' }
end

def get_auth_params_from_login_response_headers(response)
  {
      'access-token': response.headers['access-token'],
      'client': response.headers['client'],
      'uid': response.headers['uid']
  }
end

def auth_headers(user)
  user.create_new_auth_token
      .merge('ACCEPT' => 'application/json')
end

def response_hash
  JSON.parse response.body
end
