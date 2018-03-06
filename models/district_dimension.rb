class DistrictDimension
  include DataMapper::Resource

  property :id, Serial, :index => true
  property :code, String, :length => 4
  property :name, String, :length => 80
  property :county, String, :length => 80
end
