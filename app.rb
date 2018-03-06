require 'haml'
require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    @district = 'Swampscott'
    
    @rows = EnrollmentFact.all(district_dimension_id: 200, grade_dimension_id: 2)
    haml :index
  end
  
end
