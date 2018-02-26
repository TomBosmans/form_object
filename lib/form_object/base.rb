require 'form_object/field'

class FormObject::Base
  include ActiveModel::Model

  def fields_for(resource)
    fields.select { |field| field.resource == resource.to_s.underscore }
  end

  def self.fields
    @fields ||= []
  end

  def fields
    self.class.fields
  end

  def self.resources
    @resources ||= []
  end

  def resources
    self.class.resources
  end

  def self.resource(resource)
    @current_resource = resource.to_s.underscore
    resources << @current_resource
    create_resource_setter(@current_resource)
    yield if block_given?
    create_attributes_method(@current_resource)
  end

  def self.field(name, type: nil)
    field = FormObject::Field.new(name, resource: @current_resource, type: type)
    fields << field
    create_attr_accessor(field.full_name)
    field
  end

  def valid?(args = {})
    super
    args.each do |resource_name, resource|
      move_errors_from(resource_name, resource) unless resource.valid?
    end
    !errors.present?
  end

  private

  def move_errors_from(resource_name, resource)
    move_errors_details_from(resource_name, resource)
    move_errors_messages_from(resource_name, resource)
  end

  def move_errors_details_from(resource_name, resource)
    resource.errors.details.map do |key, value|
      form_key = "#{resource_name}_#{key}".to_sym
      errors.details[form_key] = [] unless errors.details[form_key]
      errors.details[form_key].push(value).flatten
    end
  end

  def move_errors_messages_from(resource_name, resource)
    resource.errors.messages.map do |key, value|
      form_key = "#{resource_name}_#{key}".to_sym
      errors.messages[form_key] = [] unless errors.messages[form_key]
      errors.messages[form_key].push(value).flatten
    end
  end

  def self.create_attr_accessor(name)
    class_eval do
      attr_accessor name
    end
  end

  def self.create_resource_setter(resource_name)
    define_method "#{resource_name}=" do |resource|
      return unless resource
      fields_for(resource_name).each do |field|
        value = resource.public_send(field.name)
        public_send("#{field.full_name}=", value)
      end
    end
  end

  def self.create_attributes_method(resource_name)
    define_method "#{resource_name}_attributes" do
      attributes = {}
      fields_for(resource_name).each do |field|
        attributes[field.name] = public_send(field.full_name)
      end
      attributes
    end
  end
end
