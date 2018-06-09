ActiveAdmin.register Department do

  permit_params do
    [:uuid, :ranking, :submission_deadline, :picturable_class, :university_id, :name_en, :name_cn, :details_cn, :details_en, :gallery_images_attributes => [:id, :image, :pictureable_id, :pictureable_type, :uuid, :picturable_class]]
  end

  show do
    attributes_table do
      row :name_en
      row :name_cn
      row :details_en
      row :details_cn
    end

    attributes_table do
      row :submission_deadline
      row :ranking
    end

    attributes_table heading: "Gallery Images" do
      department.gallery_images.find_each do |img|
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
    column :university
    column :ranking
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    inputs do
      f.input :university
      f.input :uuid, input_html: {value: "#{f.object.uuid}"}, as: :hidden
    end

    inputs do
      f.input :name_en
      f.input :name_cn
      f.input :details_en
      f.input :details_cn
    end

    inputs do
      f.input :ranking
      f.input :submission_deadline
    end

    f.inputs "Gallary" do
      f.has_many :gallery_images do |cf|
        cf.input :image
        cf.input :uuid, input_html: {value: "#{f.object.uuid}"}, as: :hidden
      end
    end

    actions
  end

  controller do
    def new
      @department = Department.new uuid: SecureRandom.uuid
    end

    def edit
      @department = Department.friendly.find(params[:id])
    end

    def show
      @department = Department.friendly.find(params[:id])
    end

  end

end
