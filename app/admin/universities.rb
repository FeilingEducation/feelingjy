ActiveAdmin.register University do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #

  permit_params do
    permitted = [:name_en, :name_cn, :description_cn, :description_en, :logo]
    # permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  show do
    attributes_table do
      row :name_en
      row :name_cn
      row :image do |university|
        image_tag university.logo.url
      end
      row :description_en
      row :description_cn

    end
  end

  index do
    id_column
    column :name_en
    column :name_cn
    column :logo do |university|
      image_tag university.logo.url(:thumb)
    end
    actions
  end

  controller do

    def new
      @university = University.new
    end

    def edit
      @university = University.find(params[:id])
    end

  end

  form do |f|
    inputs do
      input :name_en
      input :name_cn
      input :description_en
      input :description_cn

      input :logo
    end

    actions

  end

end
