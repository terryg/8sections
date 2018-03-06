class GradeDimension
  include DataMapper::Resource

  property :id, Serial, :index => true
  property :sequence, Integer, :key => true
  property :name, String, :length => 80
end
