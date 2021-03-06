ActiveAdmin.register Image do
  menu label: "Images", priority: 4, parent: "Content"

  config.filters = false
  config.paginate = false
  config.batch_actions = false

  controller do
    def permitted_params
      params.permit(image: [:file, :label])
    end
  end

  index download_links: false do |image|
    render partial: 'admin/sortable_images'
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
    f.inputs do
      f.input :file
      f.input :label
    end

    f.actions
  end

  collection_action :sort, method: :post do
    if params[:image].try(:is_a?, Array)
      params[:image].each_with_index do |id, index|
        ActiveRecord::Base.connection.execute("UPDATE images SET sort_order = #{index + 1} WHERE id = #{id.to_i}")
      end
    end

    render nothing: true
  end

  action_item only: :show do
    link_to("New Image", new_admin_image_path)
  end
end
