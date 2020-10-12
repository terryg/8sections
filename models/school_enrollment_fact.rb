# frozen_string_literal: true

require './models/district_dimension'
require './models/school_dimension'
require './models/time_dimension'

# a fact about school enrollment
class SchoolEnrollmentFact
  include DataMapper::Resource

  property :id, Serial, index: true
  property :enrollment, Integer

  belongs_to :district_dimension
  belongs_to :school_dimension
  belongs_to :time_dimension
end
