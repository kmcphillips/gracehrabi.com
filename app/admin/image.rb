ActiveAdmin.register Image do
  menu label: "Images", priority: 4

  config.filters = false

  controller do
    def permitted_params
      params.permit(image: [:file, :label])
    end
  end

  index as: :grid do |image|
    link_to image_tag(image.thumb), admin2_image_path(image)
  end

  show title: :label do |image|
    attributes_table do
      row :image do
        image_tag(image.inline)
      end
      row :label
    end
  end

  form do |f|
    if !f.object.new_record?
      f.inputs do 
        f.template.render partial: 'admin2/image', locals: {f: f}
      end
    end

    f.inputs do
      if f.object.new_record?
        f.input :file
      end

      f.input :label
    end

    f.actions
  end

end
