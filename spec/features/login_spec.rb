require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

describe 'password authentication' do
  describe 'register' do
    before do
      visit root_path
    end

    it 'register TRUE' do
      register('test@test.com', '12345', '12345', 'Зарегистрироваться')
      expect(page).to have_content 'Пользователь успешно создан.'
    end

    it 'password confirmation FALSE' do
      register('test@test.com', '12345', '56789', 'Зарегистрироваться')
      expect(page).to have_content "Значения не совпадают."
    end

    it 'e-mail FALSE' do
      register('test', '12345', '12345', 'Зарегистрироваться')
      expect(page).to have_content 'Не верный формат.'
    end

    it 'e-mail has already been taken' do
      register('test@test.com', '12345', '12345', 'Зарегистрироваться')
      click_link 'Выйти'
      register('test@test.com', '12345', '12345', 'Зарегистрироваться')
      expect(page).to have_content 'Не уникальное значение.'
    end

    it 'password is too short' do
      register('test@test.com', '1', '12345', 'Зарегистрироваться')
      expect(page).to have_content 'Короткое значение.'
    end

    it 'password_confirmation is too short' do
      register('test@test.com', '12345', '1', 'Зарегистрироваться')
      expect(page).to have_content 'Значения не совпадают.'
    end
  end

  describe 'authentication' do
    before do
      create(:user)
      visit root_path
    end

    it 'require_login root' do
      expect(page).to have_content I18n.t(:welcome, locale: I18n.locale)
    end

    it 'authentication TRUE' do
      login_by_email('test@test.com', '12345', 'Войти')
      user = User.find_by(email: 'test@test.com')
      expect(page).to have_content I18n.t(:log_in_is_successful_notice, locale: user.locale)
    end

    it 'incorrect e-mail' do
      login_by_email('1@1.com', '12345', 'Войти')
      expect(page).to have_content I18n.t(:not_logged_in_alert, locale: I18n.locale)
    end

    it 'incorrect password' do
      login_by_email('test@test.com', '56789', 'Войти')
      expect(page).to have_content I18n.t(:not_logged_in_alert, locale: I18n.locale)
    end

    it 'incorrect e-mail and password' do
      login_by_email('1@1.com', '56789', 'Войти')
      expect(page).to have_content I18n.t(:not_logged_in_alert, locale: I18n.locale)
    end
  end

  describe 'change language' do
    before do
      visit root_path
    end

    it 'home page' do
      click_link 'en'
      expect(page).to have_content I18n.t(:welcome, locale: 'en')
    end

    it 'register TRUE' do
      click_link 'en'
      register('test@test.com', '12345', '12345', 'Sing up')
      expect(page).to have_content I18n.t(:user_created_successfully_notice, locale: 'en')
    end

    it 'default locale' do
      click_link 'en'
      register('test@test.com', '12345', '12345', 'Sing up')
      user = User.find_by(email: 'test@test.com')
      expect(user.locale).to eq('en')
    end

    it 'available locale' do
      click_link 'en'
      register('test@test.com', '12345', '12345', 'Sing up')
      click_link 'User profile'
      fill_in 'user[password]', with: '12345'
      fill_in 'user[password_confirmation]', with: '12345'
      click_button 'Сохранить'
      expect(page).to have_content I18n.t(:user_profile_updated, locale: 'en')
    end

    it 'authentication TRUE' do
      create(:user)
      click_link 'en'
      login_by_email('test@test.com', '12345', 'Log in')
      user = User.find_by(email: 'test@test.com')
      expect(page).to have_content I18n.t(:log_in_is_successful_notice, locale: user.locale)
    end
  end
end
