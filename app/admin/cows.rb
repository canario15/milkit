# frozen_string_literal: true

ActiveAdmin.register Cow do
  permit_params do
    permitted = %i[caravan birth_date status tambo_id cow_type 
                   due_date service_num service_date date bull]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  filter :tambo, collection: proc { Tambo.all }, as: :select
  filter :caravan

  index do
    column :id
    column :caravan
    column :tambo
    column('Estado') { |cow| cow.status_name }
    actions
  end

  show do |cow|
    attributes_table do
      row :id
      row :caravan
      row :tambo
      row('Estado') { cow.status_name }
      row('Tipo') { cow.cow_type_name }
      row :birth_date
      row :due_date
      row :service_num
      row :service_date
      row :created_at
      row :updated_at
      row :events do
        table_for cow.events do
          column :date_event
          column('Evento') { |event| event.action_name }
          column :notification
          column('Acciones') { |event| link_to('Ver', admin_event_path(event)) }
          column('') { |event| link_to('Editar', edit_admin_event_path(event)) }
        end
      end
    end
  end
end
