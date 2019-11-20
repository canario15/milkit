# frozen_string_literal: true

ActiveAdmin.register Tambo do
  permit_params do
    permitted = %i[name address phone_contact user_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  filter :name

  index do
    column :id
    column :name
    column :address
    column :user
    column :phone_contact
    actions
  end
end
