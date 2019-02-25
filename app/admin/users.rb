ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :email
    column :current_block_id
    column :locale
    column :created_at
    column :updated_at
    actions
  end

  permit_params :email, :current_block_id, :locale
end
