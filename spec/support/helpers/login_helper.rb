module LoginHelper
  def login_by_email(email, password, action = I18n.t(:log_in_label))
    click_link(action)
    fill_in('email', with: email)
    fill_in('password', with: password)
    click_button(action)
  end

  def login_admin
    @user = create(:admin)
    visit root_path
    click_link(I18n.t(:log_in_label))
    fill_in('email', with: @user.email)
    fill_in('password', with: '12345')
    click_button(I18n.t(:log_in_label))
  end

  def login_user(user = nil)
    user = create(:user) unless user
    visit root_path
    click_link(I18n.t(:log_in_label))
    fill_in('email', with: user.email)
    fill_in('password', with: '12345')
    click_button(I18n.t(:log_in_label))
    @user = user
  end

  def register(email, password, password_confirmation, action)
    visit(new_user_path)
    fill_in('user[email]', with: email)
    fill_in('user[password]', with: password)
    fill_in('user[password_confirmation]', with: password_confirmation)
    click_button(action)
  end
end
