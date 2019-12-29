# frozen_string_literal: true

# the grade dimension
class GradeDimension
  include DataMapper::Resource

  property :id, Serial, index: true
  property :sequence, Integer, required: true
  property :name, String, length: 80
end
