require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:user) { create(:user) }

  it 'does not have an admin role' do
    expect(user.admin?).to be false
  end

  it 'adds admin role' do
    user.add_role(:admin)
    expect(user.admin?).to be true
  end

  it 'removes admin role' do
    user.add_role(:admin)
    user.remove_role(:admin)
    expect(user.admin?).to be false
  end
end
