# frozen_string_literal: true

ActiveAdmin.register Event do
  permit_params do
    permitted = %i[cow_id date_event action bull notification observations]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  filter :id

  index do
    column :id
    column('Vaca') { |event| link_to( event.cow.caravan, admin_cow_path(event.cow)) }
    column('Tambo') { |event| event.cow.tambo }
    column('Evento') { |event| event.action_name }
    actions
  end

  show do
    attributes_table do
      row :id
      row('Vaca') { |event| link_to( event.cow.caravan, admin_cow_path(event.cow)) }
      row :date_event
      row('Evento') { |event| event.action_name }
      row :notification
      row :observations
      row :bull
      row :created_at
      row :updated_at
    end
  end
end
