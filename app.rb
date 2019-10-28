require 'haml'
require 'sinatra/base'

class App < Sinatra::Base

  before do
    set_instance_variables
  end

  get '/' do
    @years = TimeDimension.all(order: [ :id.asc ])
    @series = []
    haml :index
  end

  get '/enrollment' do
    districts = ['Swampscott']
    districts = params[:districts].split(',') if params[:districts]

    grades = Array.new
    @all_grades.each do |g|
      grades.push(g.name) if !params[g.name].nil?
    end

    grades = %w[PK K GR1 GR2 GR3 GR4 GR5 GR6 GR7 GR8 GR9 GR10 GR11 GR12 22] if grades.empty?
    
    @districts = DistrictDimension.all(name: districts)

    @grades = GradeDimension.all(name: grades)
    @years = TimeDimension.all(:year.gte => 2003, :order => [ :id.asc ])
    
    @series = []
    @districts.each do |d|
      facts = EnrollmentFact.aggregate(fields: [:enrollment.sum, :time_dimension_id],
                                       
                                       district_dimension_id: d.id,
                                       grade_dimension_id: @grades.collect{|g| g.id},
                                       order: [ :time_dimension_id.asc ])
      facts.each do |f|
        f << TimeDimension.first(id: f[1]).year
      end
      @series.push(facts)
    end

    @high = 0
    @series.each do |series|
      series.each do |s|
        step = s[0] / 100
        high = step * 100 + 100
        @high = high if high > @high
      end
    end

    @series.each do |y|
      n = y[0].length

      y_bar = y[0].reduce(0){|sum,i| sum + i} / n

      x = @years.collect{|yr| yr.year}
      x_bar = x.reduce(0){|sum,i| sum + i} / n

      s_x = x.reduce(0){|sum,i| sum + (i - x_bar)*(i - x_bar)}

      i = 0
      s_x_y = 0
      while i < n
        s_x_y = s_x_y + (x[i] - x_bar)*(y[0][i] - y_bar)
        i = i + 1
      end

      m = s_x_y/s_x

       b = y_bar - m * x_bar

       puts "m #{m}"
       puts "b #{b}"

       puts "#{m / y_bar.to_f}"
    end

    haml :enrollment
  end
  
  get '/salaries' do
    districts = ['Swampscott']
    districts = params[:districts].split(',') if params[:districts]

    @districts = DistrictDimension.all(name: districts)
    @districts.push(DistrictDimension.first(code: '0000'))

    @years = TimeDimension.all(:year.gte => 1997, :year.lte => 2017, :order => [ :year.asc ])
    @labels = @years.collect{|y| y.year.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
    
    @series = []
    @districts.each do |d|
      pp @years.collect{|y| y.id}
      facts = SalaryFact.all(time_dimension_id: @years.collect{|y| y.id},
                             district_dimension_id: d.id)
      pp facts
      facts.sort!{|a,b| a.time_dimension.year <=> b.time_dimension.year}
      @series.push(facts.collect{|f| f.average})
    end

    pp @series

    @high = 0
    @series.each do |s|
      
      pp s

      step = s.max / 100
      high = step * 100 + 100
      @high = high if high > @high
    end

    @series.each do |y|
      n = y.length

      y_bar = y.reduce(0){|sum,i| sum + i} / n

      x = @years.collect{|yr| yr.year}
      x_bar = x.reduce(0){|sum,i| sum + i} / n

      s_x = x.reduce(0){|sum,i| sum + (i - x_bar)*(i - x_bar)}

      i = 0
      s_x_y = 0
      while i < n
        s_x_y = s_x_y + (x[i] - x_bar)*(y[i] - y_bar)
        i = i + 1
      end

      m = s_x_y/s_x

       b = y_bar - m * x_bar

       puts "m #{m}"
       puts "b #{b}"

       puts "#{m / y_bar.to_f}"
    end

    haml :salaries
  end

  def set_instance_variables
    @all_districts = DistrictDimension.all 
    @all_grades = GradeDimension.all
  end

end
