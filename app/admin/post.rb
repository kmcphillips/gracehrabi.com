ActiveAdmin.register Post do
  menu label: "News Posts", priority: 1

  filter :title
  filter :created_at

  controller do
    defaults finder: :find_by_permalink
  end

  index format: :blog, download_links: false do
    column :title do |post|
      link_to post.title, admin2_post_path(post)
    end
    # column :body do |post|
    #   truncate post.body, length: 300, omission: '...'
    # end
    column :created_at
    column :age do |post|
      "#{ distance_of_time_in_words_to_now(post.created_at) } ago"
    end
    default_actions
  end

end
