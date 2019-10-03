ActiveAdmin.register User do
  permit_params %i[email password password_confirmation]

  form do |f|
    f.inputs "Usuarios" do
      f.input :email
      f.input :password
      f.input :password_confirmation
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
