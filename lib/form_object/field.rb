class FormObject::Field
  attr_accessor :name, :resource, :type, :options

  def initialize(name, options = {})
    self.name = name
    self.resource = options[:resource]
    self.type = options[:type] || find_type
    self.options = options.with_indifferent_access
  end

  def full_name
    "#{resource}_#{name}"
  end

  def label
    return options[:label] if options[:label]
    model_class.human_attribute_name(name)
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
    db_column_info ? db_column_info.type.to_sym : :string
  end
end
