require 'test_helper'

describe FormObject::Field do
  describe '#find_type' do
    it 'should return integer for Author.new.age' do
      field = FormObject::Field.new(:age, resource: 'author')
      assert :integer, field.type.to_sym
    end
  end
end
