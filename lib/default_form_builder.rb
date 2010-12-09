class DefaultFormBuilder < ActionView::Helpers::FormBuilder 
  
  def datetime(name, opts={})
    text_field(name, opts)
  end
  
  def image
    @template.render :partial => "/shared/image_form", :locals => {:f => self, :object => self.object}
  end
end
