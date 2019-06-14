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

require './models/enrollment_fact'

DataMapper.finalize
DataMapper.auto_upgrade!

