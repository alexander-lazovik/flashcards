require 'rails_helper'
require 'support/helpers/login_helper.rb'

describe 'Card Image test:' do
  include LoginHelper

  describe 'user', type: :feature do
    let!(:user) { create(:user) }
    let!(:block) { create(:block, user: user) }

    before do
      login_user(user)
      visit new_card_path
    end

    it 'creates a new card' do
      expect(page).to have_css '.new_card'
      fill_in 'card_original_text', with: 'Test'
      fill_in 'card_translated_text', with: 'Тест'
      select(block.title, from: 'card_block_id')
      click_button('submit_button')
      expect(page).to have_content(I18n.t(:card_created_notice, locale: user.locale))
    end
  end

  # describe 'creates a new card with photo', type: :feature, js: true do
  #   let!(:user) { create(:user) }
  #   let!(:block) { create(:block, user: user) }

  #   before do
  #     login_user(user)
  #     visit new_card_path
  #   end

  #   it 'searches Flickr photos and selects the first one' do
  #     click_link(I18n.t(:load_image_label, locale: user.locale))
  #     fill_in 'tags', with: 'sunset'
  #     click_button I18n.t(:search_label, locale: user.locale)
  #     expect(page).to have_css('#image_0', wait: 10)
  #     click_link('image_0')
  #     expect(page).to have_css('#card_image_url', wait: 10)
  #     fill_in 'card_original_text', with: 'Test'
  #     fill_in 'card_translated_text', with: 'Тест'
  #     select(block.title, from: 'card_block_id')
  #     click_button('submit_button')
  #     expect(page).to have_content(I18n.t(:card_created_notice, locale: user.locale))
  #   end
  # end
end
