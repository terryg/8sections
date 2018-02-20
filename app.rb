require 'haml'
require 'sqlite3'
require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    db = SQLite3::Database.new('data/develop.db')
    @district = 'Swampscott'
    @rows = db.execute("SELECT t.year, size FROM enrollment_facts e INNER JOIN time_dimension t ON e.time_id = t.id WHERE district_id = 200 AND grade_id = 2 ORDER BY year")
    haml :index
  end
  
end
