require './models/district_dimension'
require './models/time_dimension'

class SalaryFact
  include DataMapper::Resource

  property :id, Serial, :index => true
  property :total, Integer, :min => 0, :max => 281474976710656
  property :average, Integer, :min => 0, :max => 281474976710656
  property :full_time_employees, Integer, :min => 0, :max => 281474976710656

  belongs_to :district_dimension
  belongs_to :time_dimension

end