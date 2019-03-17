require 'haml'
require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    @all_districts = DistrictDimension.all 
    @all_grades = GradeDimension.all

    
    districts = ['Swampscott']
    districts = params[:districts].split(',') if params[:districts]

    grades = ['K','gr1','gr2','gr3', 'gr4']
    grades = params[:grades].split(',') if params[:grades]
   
    @districts = DistrictDimension.all(name: districts)
    @grades = GradeDimension.all(name: grades)
    @years = TimeDimension.all(order: [ :id.desc ])
    
    @series = []
    @districts.each do |d|
      facts = EnrollmentFact.aggregate(fields: [:enrollment.sum, :time_dimension_id],
                                       
                                       district_dimension_id: d.id,
                                       grade_dimension_id: @grades.collect{|g| g.id},
                                       order: [ :time_dimension_id.desc ])
      facts.each do |f|
        f << TimeDimension.first(id: f[1]).year
      end
      puts "FACTS #{facts}"
      @series.push(facts)
    end

    @years << TimeDimension.new(year: 2018)
    @years << TimeDimension.new(year: 2019)
    @years << TimeDimension.new(year: 2020)
    
    @high = 0
    @series.each do |series|
      series.each do |s|
        step = s[0] / 100
        high = step * 100 + 100
        @high = high if high > @high
      end
    end

    predictions = []
    
    @series.each do |series|
      n = series.length
      y = series.collect{|s| s[0]}
      s = y.inject(0){|sum,i| sum + i}
      puts "y #{y}"
      puts "SUM #{s}"
      puts "AVG #{s/n}"
      y_bar = s/n

      s_y = 0
      y.each do |i|
        s_y = s_y + (i - y_bar)*(i - y_bar)
      end
      
      x = series.collect{|s| s[2]}
      s = x.inject(0){|sum,i| sum + i}
      puts "x #{x}"
      puts "SUM #{s}"
      puts "AVG #{s/n}"
      x_bar = s/n

      s_x = 0
      x.each do |i|
        s_x = s_x + (i - x_bar)*(i - x_bar)
      end

      i = 0
      s_x_y = 0
      while i < n
        s_x_y = s_x_y + (x[i] - x_bar)*(y[i] - y_bar)
        i = i + 1
      end

      b = s_x_y/s_x

      a = y_bar - b * x_bar

      series << [nil, 0, 2018]
      series << [nil, 0, 2019]
      series << [nil, 0, 2020]

      prediction = []

      yr = 2003
      while yr < 2018
        prediction << [nil, 0, yr]
        yr = yr + 1
      end
      
      prediction << [b*2018+a, 0, 2018]
      prediction << [b*2019+a, 0, 2019]
      prediction << [b*2020+a, 0, 2020]

      predictions << prediction
    end

    predictions.each do |p|
      @series << p
    end
    
    haml :index
  end
  
end
