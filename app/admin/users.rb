ActiveAdmin.register User do
  permit_params %i[email]

  form do |f|
    f.inputs 'User' do
      f.input :email
    end
    f.actions
  end

  index do
    column :email
    column :created_at
    actions
  end

  show title: :email do |ad|
    attributes_table do
      row :email
      row :created_at
      row :updated_at
    end
  end

end
