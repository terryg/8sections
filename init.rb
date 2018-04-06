require 'rubygems'

require 'dm-core'
require 'dm-migrations'
require 'dm-postgres-adapter'
require 'dm-validations'
require 'haml'
require 'sinatra'

configure { set :server, :puma }

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || ENV['HEROKU_POSTGRESQL_GRAY_URL'])

require './models/enrollment_fact'

DataMapper.finalize
DataMapper.auto_upgrade!

