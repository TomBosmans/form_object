module FormObject
  class Engine < ::Rails::Engine
    isolate_namespace FormObject
  end
end

require 'form_object/base'
require 'form_object/field'
