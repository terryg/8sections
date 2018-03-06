class TimeDimension
  include DataMapper::Resource

  property :id, Serial, :index => true
  property :year, Integer, :key => true
end
