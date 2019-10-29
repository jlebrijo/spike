class MyDeviseMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    MyDeviseMailer.confirmation_instructions(User.first, "faketoken", {})
  end

  def reset_password_instructions
    MyDeviseMailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def unlock_instructions
    MyDeviseMailer.unlock_instructions(User.first, "faketoken", {})
  end

  def email_changed
    MyDeviseMailer.email_changed(User.first, {})
  end

  def password_change
    MyDeviseMailer.password_change(User.first, {})
  end
end