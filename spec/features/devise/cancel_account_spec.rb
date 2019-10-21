# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'Cancel Account', :devise do
  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  scenario 'user can delete own account' do
    user = create :user
    signin(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    visit edit_user_registration_path(user)
    click_link 'Cancel my account'
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end
end
