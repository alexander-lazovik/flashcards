class User < ApplicationRecord
  rolify
  has_many :cards, dependent: :destroy
  has_many :blocks, dependent: :destroy
  has_many :authentications, dependent: :destroy

  belongs_to :current_block, class_name: 'Block', optional: true
  before_create :set_default_locale
  before_validation :set_default_locale, on: :create

  accepts_nested_attributes_for :authentications

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  attr_accessor :skip_password_validation

  validates :password, confirmation: true, presence: true,
            length: { minimum: 3 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :email, uniqueness: true, presence: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :locale, presence: true,
            inclusion: { in: I18n.available_locales.map(&:to_s),
                         message: 'Выберите локаль из выпадающего списка.' }

  def has_linked_github?
    authentications.where(provider: 'github').present?
  end

  def set_current_block(block)
    update_attribute(:current_block_id, block.id)
  end

  def reset_current_block
    update_attribute(:current_block_id, nil)
  end

  def admin?
    has_role? :admin
  end

  private

  def set_default_locale
    self.locale = I18n.locale.to_s
  end

  def password_required?
    !skip_password_validation
  end
end
