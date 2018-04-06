require 'haml'
require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    @all_districts = DistrictDimension.all 
    @all_grades = GradeDimension.all

    districts = params[:districts].split(',') || 'Swampscott'
    grade = params[:grade] || 'K'
    
    @districts = DistrictDimension.all(name: districts)
    @grade = GradeDimension.first(name: grade)

    @series = []
    @districts.each do |d|
      facts = EnrollmentFact.all(district_dimension_id: d.id,
                                 grade_dimension_id: @grade.id,
                                 order: [ :time_dimension_id.desc ])
      puts "FACTS #{facts}"
      @series.push(facts)
    end

    puts "@SERIES #{@series}"

    @years = []
   
    @high = 0
    @series.each do |series|
      puts "SERIES #{series}"
      series.each do |s|
        puts "S #{s}"
        @years << s.time_dimension.year
        step = s.enrollment / 100
        high = step * 100 + 100
        @high = high if high > @high
      end
    end

    @years.uniq!
      
    haml :index
  end
  
end
