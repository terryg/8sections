# frozen_string_literal: true

# the school building dimension
class SchoolDimension
  include DataMapper::Resource

  property :id, Serial, index: true
  property :code, String, length: 6, unique: true
  property :name, String, length: 80, required: true
  property :primary, String, length: 8
  property :secondary, String, length: 8

  def primary_color
    "##{primary}"
  end

  def secondary_color
    "##{secondary}"
  end
end
