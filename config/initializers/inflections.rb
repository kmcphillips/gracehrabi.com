ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.uncountable %w( fish sheep )

    inflect.irregular 'media', 'medias'  ## This changed from 3.0 to 3.0.9

end
