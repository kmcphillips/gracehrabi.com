class ReadOnlyAdapter < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject=nil)
    !Settings.read_only
  end

end
