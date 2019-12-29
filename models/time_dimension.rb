# frozen_string_literal: true

# the time dimension
class TimeDimension
  include DataMapper::Resource

  property :id, Serial, index: true
  property :year, Integer
end
