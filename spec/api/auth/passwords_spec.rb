describe 'Passwords', type: :request do
  let(:user) { create :user }

  describe 'POST /auth/password' do
    before do
      ActionMailer::Base.deliveries.clear
      post auth_user_password_path,
           params: { email: user.email,
                     redirect_url: 'http://google.com' }
      @email = ActionMailer::Base.deliveries.last
    end

    it 'sends an email with reset instructions' do
      expect(@email.subject).to eq 'Reset password instructions'
    end

    it 'clicking the link you are redirected with auth_headers' do
      document = Nokogiri::HTML(@email.body.to_s)
      change_url = document.search('a').attribute('href').to_s.remove('http://localhost:3000')
      get change_url

      expect(body).to include 'access-token'
      expect(body).to include 'client'
      expect(body).to include 'uid'
    end
  end

  it 'PUT /auth/password: updates password' do
    expect(user).to be_valid_password user.password
    new_pass = '12345678'
    put auth_user_password_path(password: new_pass,
                                  password_confirmation: new_pass),
          headers: auth_headers(user)
    expect(user.reload).to be_valid_password new_pass
  end
end
