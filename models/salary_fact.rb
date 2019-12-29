# frozen_string_literal: true

require './models/district_dimension'
require './models/time_dimension'

# a fact about salary
class SalaryFact
  include DataMapper::Resource

  property :id, Serial, index: true
  property :total, Integer, min: 0, max: 281_474_976_710_656
  property :average, Integer, min: 0, max: 281_474_976_710_656
  property :full_time_employees, Integer, min: 0, max: 281_474_976_710_656

  belongs_to :district_dimension
  belongs_to :time_dimension
end
