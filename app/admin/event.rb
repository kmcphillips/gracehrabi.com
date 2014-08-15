ActiveAdmin.register Event, as: "Show" do
  menu label: "Shows", priority: 2

  config.sort_order = "starts_at_desc"
  config.batch_actions = false

  filter :title
  filter :starts_at
  filter :publicized

  controller do
    def permitted_params
      params.permit(show: [:title, :description, :publicized, :starts_at, :price, :image, :clear_image, :previous_image_id, :location])
    end

    private

    helper_method :publish_to_facebook_confirm
    def publish_to_facebook_confirm(event)
      if event.published_to_facebook?
        "This event has already been published to Facebook! This will NOT delete or update the existing event. Are you sure you want to publish it again?"
      else
        "Are you sure you want to publish this event to Facebook?"
      end
    end

    def build_new_resource
      if source_event = Event.find_by_id(params[:source_id])
        source_event.dup
      else
        super
      end
    end

  end

  index format: :blog, download_links: false do
    column :title do |event|
      link_to event.title, admin_show_path(event)
    end
    column "Start date", :starts_at
    column :in do |event|
      distance_of_time_in_words_to_now(event.starts_at) unless event.starts_at < Time.now
    end
    column :publicized do |event|
      boolean_image event.publicized
    end
    column :facebook do |event|
      "#{ distance_of_time_in_words_to_now(event.published_to_facebook_at) } ago" if event.published_to_facebook?
    end
    actions do |event|
      render partial: "admin/events/index_social_buttons", object: event
      nil
    end
  end

  show do |event|
    attributes_table do
      row :starts_at
      row :in do
        distance_of_time_in_words_to_now(event.starts_at) unless event.starts_at < Time.now
      end
      row :publicized do
        boolean_image event.publicized
      end
      row :published_to_facebook do
        if event.published_to_facebook?
          "#{ distance_of_time_in_words_to_now(event.published_to_facebook_at) } ago"
        else
          "Never"
        end
      end
      row :location
      row :price do
        number_to_currency(event.price) if event.price
      end
      row :image do
        image_tag(event.inline) if event.image.exists?
      end
      row :description do
        auto_link(simple_format(event.description)).html_safe
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :starts_at, as: :datetime_picker
      f.input :location, hint: "Used only for Facebook to plot the event on a map."
      f.input :price
      f.input :publicized
    end
    f.inputs do
      f.template.render partial: 'admin/attached_image', locals: {f: f}
    end

    f.actions
  end

  action_item only: :show do
    link_to("Publish to Facebook", "", data: {"publish-facebook-event" => resource.id, "confirm" => publish_to_facebook_confirm(resource)}) +
    link_to("Duplicate", new_admin_show_path(source_id: resource.id)) +
    link_to("New Show", new_admin_show_path)
  end

  member_action :facebook, method: :post do
    facebook = resource.new_facebook(params[:access_token])

    if facebook.save
      flash[:notice] = "Event successfully published to Facebook."
    else
      flash[:error] = facebook.errors.full_messages.to_sentence
    end

    redirect_to admin_show_path(resource)
  end

end
