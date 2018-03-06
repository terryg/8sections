require './models/district_dimension'
require './models/grade_dimension'
require './models/time_dimension'

class EnrollmentFact
  include DataMapper::Resource

  property :id, Serial, :index => true
  property :enrollment, Integer

  belongs_to :district_dimension
  belongs_to :grade_dimension
  belongs_to :time_dimension

end
