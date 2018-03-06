require 'haml'
require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    @district = 'Swampscott'
    
    @rows = EnrollmentFact.all(district_dimension_id: 200,
                               grade_dimension_id: 2,
                               order: [ :time_dimension_id.desc ])
    haml :index
  end
  
end
