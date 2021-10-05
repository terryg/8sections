# frozen_string_literal: true

require 'rubygems'

require 'dm-core'
require 'dm-migrations'
require 'dm-postgres-adapter'
require 'dm-validations'
require 'dm-aggregates'
require 'sinatra'

configure { set :server, :puma }

# DataMapper::Logger.new($stdout, :debug)
# DataMapper::Model.raise_on_save_failure = true
DataMapper.setup(:default, ENV['DATABASE_URL'])

require_relative './models/school_enrollment_fact'
require_relative './models/enrollment_fact'
require_relative './models/salary_fact'
require_relative './models/district_dimension'
require_relative './models/school_dimension'

DataMapper.finalize
DataMapper.auto_upgrade!

d = DistrictDimension.first(name: 'lexington')
d&.update(primary: '001b40')

d = DistrictDimension.first(name: 'lynn')
d&.update(primary: '610301')

d = DistrictDimension.first(name: 'lynnfield')
d&.update(primary: 'fbb20f')

d = DistrictDimension.first(name: 'marblehead')
d&.update(primary: '000000')

d = DistrictDimension.first(name: 'salem')
d&.update(primary: 'ff1400')

d = DistrictDimension.first(name: 'swampscott')
d&.update(primary: '010765')

d = DistrictDimension.first(name: 'scituate')
d&.update(primary: '2848b7')
