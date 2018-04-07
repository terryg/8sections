require 'haml'
require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    @all_districts = DistrictDimension.all 
    @all_grades = GradeDimension.all

    
    districts = 'Swampscott'
    districts = params[:districts].split(',') if params[:districts]

    grades = 'K' 
    grades = params[:grades].split(',') if params[:grades]
   
    @districts = DistrictDimension.all(name: districts)
    @grades = GradeDimension.all(name: grades)
    @years = TimeDimension.all(order: [ :id.desc ])

    
    @series = []
    @districts.each do |d|
      facts = EnrollmentFact.aggregate(fields: [:enrollment.sum, :time_dimension_id],
                                       
                                       district_dimension_id: d.id,
                                       grade_dimension_id: @grades.collect{|g| g.id})

      puts "FACTS #{facts}"
      @series.push(facts)
    end

    puts "@SERIES #{@series}"

   
    @high = 0
    @series.each do |series|
      series.each do |s|
        step = s[0] / 100
        high = step * 100 + 100
        @high = high if high > @high
      end
    end

    haml :index
  end
  
end
