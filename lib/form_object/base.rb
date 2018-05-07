require 'form_object/base_extension'

class FormObject::Base
  extend FormObject::BaseExtension # all class methods
  include ActiveModel::Model

  attr_accessor :fields, :resources
  attr_accessor :test1, :test2

  def initialize(params={})
    self.fields = self.class.fields
    self.resources = self.class.resources
    super(params)
  end

  def fields_for(resource)
    fields.select { |field| field.resource == resource.to_s.underscore }
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
end
