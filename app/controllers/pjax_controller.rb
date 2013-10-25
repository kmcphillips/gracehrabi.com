class PjaxController < ApplicationController
  layout :pjax_layout

  protected

  def pjax_layout
    if pjax_request?
      false
    else
      'application'
    end
  end
end
