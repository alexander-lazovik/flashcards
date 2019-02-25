class AdminPolicy < Struct.new(:user, :admin)
  def show_link?
    user.present? && user.admin?
  end
end
