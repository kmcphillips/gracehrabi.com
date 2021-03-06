ActiveAdmin.register Post do
  menu label: "News Posts", priority: 1

  config.batch_actions = false

  filter :title
  filter :created_at

  controller do
    defaults finder: :find_by_permalink

    def permitted_params
      params.permit(post: [:title, :body, :image, :clear_image, :previous_image_id])
    end
  end

  index format: :blog, download_links: false do
    column :title do |post|
      link_to post.title, admin_post_path(post)
    end
    # column :body do |post|
    #   truncate post.body, length: 300, omission: '...'
    # end
    column :created_at
    column :age do |post|
      "#{ distance_of_time_in_words_to_now(post.created_at) } ago"
    end
    actions
  end

  show do |post|
    attributes_table do
      row :created do
        "#{ post.created_at.to_s(:active_admin) } - #{ distance_of_time_in_words_to_now(post.created_at) } ago"
      end
      row :image do
        image_tag(post.inline) if post.image.exists?
      end
      row :body do
        auto_link(simple_format(post.body)).html_safe
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
    end
    f.inputs do
      f.template.render partial: 'admin/attached_image', locals: {f: f}
    end

    f.actions
  end

  action_item only: :show do
    link_to("New Post", new_admin_post_path)
  end

end
