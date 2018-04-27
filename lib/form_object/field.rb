class FormObject::Field
  attr_accessor :name, :resource, :type

  def initialize(name, resource:, type: nil)
    @name = name
    @resource = resource
    @type = type || find_type
  end

  def full_name
    "#{resource}_#{name}"
  end

  private

  def model_class
    @resource.camelize.constantize
  end

  def db_column_info
    hash = model_class.columns_hash.detect { |k, _| k == name }
    hash ? hash.last : nil
  end

  def find_type
    db_column_info ? db_column_info.type : 'string'
  end
end
