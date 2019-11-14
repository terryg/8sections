require 'rubygems'

require 'dm-core'
require 'dm-migrations'
require 'dm-postgres-adapter'
require 'dm-validations'
require 'dm-aggregates'
require 'sinatra'

configure { set :server, :puma }

#DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://eightsections:eightsections@localhost:5432/eightsections_development')

require_relative './models/enrollment_fact'
require_relative './models/salary_fact'
require_relative './models/district_dimension'

DataMapper.finalize
DataMapper.auto_upgrade!

d = DistrictDimension.first(name: 'Lexington')
d.update(primary: '001b40') unless d.nil?

d = DistrictDimension.first(name: 'Lynn')
d.update(primary: '610301') unless d.nil?

d = DistrictDimension.first(name: 'Lynnfield')
d.update(primary: 'fbb20f') unless d.nil?

d = DistrictDimension.first(name: 'Marblehead')
d.update(primary: '000000') unless d.nil?

d = DistrictDimension.first(name: 'Salem')
d.update(primary: 'ff1400') unless d.nil?

d = DistrictDimension.first(name: 'Swampscott')
d.update(primary: '010765') unless d.nil?

d = DistrictDimension.first(name: 'Scituate')
d.update(primary: '2848b7') unless d.nil?
