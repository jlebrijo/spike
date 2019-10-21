describe 'Confirmation', type: :request do
  it 'when user created a confirmation email is sent', :exclude do
    # There are no anonymous signups for now, so it is deactivated
    ActionMailer::Base.deliveries.clear
    user = create :user_not_confirmed
    email = ActionMailer::Base.deliveries.last
    expect(email.subject).to eq 'Confirmation instructions'
  end

  it 'GET /auth/confirmation: confirms user/email with confirmation_token' do
    user = create :user_not_confirmed
    expect(user).not_to be_confirmed
    get auth_user_confirmation_path(confirmation_token: user.confirmation_token,
                                      redirect_url: 'http://google.com')
    expect(user.reload).to be_confirmed
  end
end
