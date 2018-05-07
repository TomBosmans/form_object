require 'form_object/field'

module FormObject::BaseExtension
  def fields
    @fields ||= []
  end

  def resources
    @resources ||= []
  end

  def resource(resource)
    @current_resource = resource.to_s.underscore
    resources << @current_resource
    create_attr_accessor(@current_resource)
    create_resource_setter(@current_resource)
    yield if block_given?
    create_attributes_method(@current_resource)
  end

  def field(name, type: nil)
    field = FormObject::Field.new(name, resource: @current_resource, type: type)
    fields << field
    create_attr_accessor(field.full_name)
    field
  end

  def create_attr_accessor(name)
    class_eval { attr_accessor name }
  end

  def create_resource_setter(resource_name)
    define_method "#{resource_name}=" do |resource|
      return unless resource
      # Set @book
      instance_variable_set("@#{resource_name}", resource)
      # Set all book_title, book_author, ...
      fields_for(resource_name).each do |field|
        value = resource.public_send(field.name)
        public_send("#{field.full_name}=", value)
      end
    end
  end

  def create_attributes_method(resource_name)
    define_method "#{resource_name}_attributes" do
      attributes = {}
      fields_for(resource_name).each do |field|
        attributes[field.name] = public_send(field.full_name)
      end
      attributes
    end
  end
end
