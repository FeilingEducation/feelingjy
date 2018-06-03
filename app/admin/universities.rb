ActiveAdmin.register University do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #

  permit_params do
    permitted = [:name_en, :name_cn, :description_cn, :description_en, :logo, :picture_id, :gallery_images_attributes => [:id, :image, :pictureable_id, :pictureable_type]]
    # gallery_images_attributes: [:id, :image]
    # permitted << :other if params[:action] == 'create' && current_user.admin?
    # permitted << :cover_photo_attributes
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

    attributes_table heading: "" do
      row 'Cover Photo' do |university|
        if university.picture.present?
          image_tag university.cover_photo.image.url(:thumb)
        end
      end
    end

    attributes_table heading: "Gallery Images" do
      university.gallery_images.find_each do |img|
        row 'Gallery Image' do
          image_tag img.image.url(:thumb)
        end
      end
    end
  # end
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

  # def new
  #   @university = University.new
  # end

  def edit
    @university = University.find(params[:id])
    # @university.cover_photo = Picture.new(pictureable: @university) if @university.cover_photo.nil?
  end

  # def create
  #   puts '====(((())))'
  #   byebug
  #   puts '====='
  # end
  #
  # def update
  #   puts '====(((())))'
  #   byebug
  #   puts '====='
  # end

end

form do |f|
  f.semantic_errors *f.object.errors.keys
  inputs do
    f.input :name_en
    f.input :name_cn
    f.input :description_en
    f.input :description_cn

    f.input :logo
  end

  inputs "Cover Photo" do
    f.input :picture , as: :select, collection: f.object.gallery_images.map {|u| [u.image_file_name, u.id]}
  end

  # f.inputs "Cover Photo", for: [:cover_photo, f.object.cover_photo || Picture.new(pictureable: f.object)] do |cover|
  #   cover.object.pictureable = f.object
  #   hint = cover.object.image.url.match(/missing.png/) ? cover.template.content_tag(:span, 'No Image yet')
  #       : cover.template.image_tag(cover.object.image.url(:thumb))
  #   cover.input :image, hint: hint
  # end

  # f.inputs "Cover Photo" do #, for: [:cover_photo, f.object.cover_photo || Picture.new(pictureable: f.object)] do |cover|
  #   f.semantic_fields_for [:cover_photo || Picture.new ] do |j|
  #     j.input :image
  #   end
  # end
  #
  # f.inputs "Upload Gallery Images" do
  #   f.has_many :gallery_images, heading: 'Gallery Images',
  #   allow_destroy: true,
  #   new_record: "Attach" do |a|
  #     hint = a.object.image.url.match(/missing.png/) ? a.template.content_tag(:span, 'No Image yet')
  #         : a.template.image_tag(a.object.image.url(:thumb))
  #     a.input :image, hint: hint
  #   end
  # end

  f.inputs "Gallary" do
    f.has_many :gallery_images, :allow_destroy => true do |cf|
      cf.input :image
      # cf.input :pictureable_id, input_html: {value: "University-#{f}"}
    end
  end


  actions

end

end
