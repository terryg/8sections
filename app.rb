require 'haml'
require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    @districts = DistrictDimension.all 
    @grades = GradeDimension.all
   
    @district = DistrictDimension.first(name: params[:district])
    @grade = GradeDimension.first(name: params[:grade])

    @district = DistrictDimension.first(name: 'Swampscott') if @district.nil?
    @grade = GradeDimension.first(name: 'K') if @grade.nil? 
   
    @rows = EnrollmentFact.all(district_dimension_id: @district.id,
                               grade_dimension_id: @grade.id,
                               order: [ :time_dimension_id.desc ])

    @years = @rows.collect{|r| r.time_dimension.year}

    @high = 0
    @rows.each do |row|
      step = row.enrollment / 100
      high = step * 100 + 100
      @high = high if high > @high
    end

      
    haml :index
  end
  
end
