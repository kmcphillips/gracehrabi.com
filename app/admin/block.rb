ActiveAdmin.register Block, as: "Sections" do
  menu label: "Sections", priority: 3

  config.filters = false
  config.paginate = false

  actions :index, :edit, :update

  controller do
    def permitted_params
      params.permit(block: [:body, :image, :clear_image, :previous_image_id])
    end
  end

  index format: :blog, download_links: false do
    column :label do |block|
      link_to block.label.humanize, edit_admin2_section_path(block)
    end
    # column :body do |post|
    #   truncate post.body, length: 300, omission: '...'
    # end
    column :updated_at
    column :age do |post|
      "#{ distance_of_time_in_words_to_now(post.updated_at) } ago"
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :body
    end
    f.inputs do
      f.template.render partial: 'admin2/attached_image', locals: {f: f}
    end
    
    f.actions
  end

end
