require 'rails_helper'
require 'support/helpers/login_helper.rb'

describe 'Administrator tests:' do
  include LoginHelper

  describe 'admin user' do
    let!(:user) { create(:admin) }

    before do
      login_user(user)
    end

    it 'expects Admin link in header' do
      expect(page).to have_link I18n.t(:admin_label, locale: user.locale), href: admin_root_path
    end

    it 'opens Admin dashboard' do
      click_link(I18n.t(:admin_label, locale: user.locale))
      expect(page).to have_content I18n.t(:admin_dashboard_content, locale: user.locale)
    end
  end

  describe 'regular user' do
    let!(:user) { create(:user) }

    before do
      login_user(user)
    end

    it 'does not expect Admin link in header' do
      expect(page).to have_no_link I18n.t(:admin_label, locale: user.locale), href: admin_root_path
    end
  end
end
