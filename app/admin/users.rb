ActiveAdmin.register User do
  config.sort_order = 'id_asc'
  permit_params :id, :email, :current_block_id, :locale

  index do
    selectable_column
    column :id
    column :email
    column :current_block_id do |record|
      record.current_block.title if record.current_block
    end
    column :locale
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    inputs "Details" do
      input :email
      input :current_block_id, as: :select, collection: Block.pluck(:title, :id)
      input :locale, as: :select, collection: I18n.available_locales
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :current_block_id do |record|
        record.current_block.title if record.current_block
      end
      row :locale
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :set_admin, only: :show do
    link_to "Set Admin", set_admin_admin_user_path(user), method: :put unless user.admin?
  end

  action_item :remove_admin, only: :show do
    link_to "Remove Admin", remove_admin_admin_user_path(user), method: :put if user.admin?
  end

  member_action :set_admin, method: :put do
    user = User.find(params[:id])
    user.add_role(:admin)
    redirect_to admin_user_path(user)
  end

  member_action :remove_admin, method: :put do
    user = User.find(params[:id])
    user.remove_role(:admin)
    redirect_to admin_user_path(user)
  end

  controller do
    def update_resource object, attributes
      attributes.each do |attr|
        unless attr[:password].present?
          attr.delete :password
          attr.delete :password_confirmation
          object.skip_password_validation = true
        end
      end
      object.send :update_attributes, *attributes
    end
  end
end
