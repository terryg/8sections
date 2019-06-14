class DistrictDimension
  include DataMapper::Resource

  property :id, Serial, :index => true
  property :code, String, :length => 4, :unique => true
  property :name, String, :length => 80, :required => true
  property :county, String, :length => 80
end
