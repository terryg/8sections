# frozen_string_literal: true

require_relative './init'

require 'nokogiri'
require 'rake/testtask'
require 'roo'
require 'roo-xls'

Rake::TestTask.new do |t|
  t.libs << 'models'
  t.test_files = FileList['tests/*_test.rb']
  t.verbose = true
end

namespace :db do
  desc 'Create and populate the database.'
  task :seed do
    GradeDimension.first_or_create(sequence: 0, name: 'PK')
    GradeDimension.first_or_create(sequence: 1, name: 'K')
    GradeDimension.first_or_create(sequence: 2, name: 'GR1')
    GradeDimension.first_or_create(sequence: 3, name: 'GR2')
    GradeDimension.first_or_create(sequence: 4, name: 'GR3')
    GradeDimension.first_or_create(sequence: 5, name: 'GR4')
    GradeDimension.first_or_create(sequence: 6, name: 'GR5')
    GradeDimension.first_or_create(sequence: 7, name: 'GR6')
    GradeDimension.first_or_create(sequence: 8, name: 'GR7')
    GradeDimension.first_or_create(sequence: 9, name: 'GR8')
    GradeDimension.first_or_create(sequence: 10, name: 'GR9')
    GradeDimension.first_or_create(sequence: 11, name: 'GR10')
    GradeDimension.first_or_create(sequence: 12, name: 'GR11')
    GradeDimension.first_or_create(sequence: 13, name: 'GR12')
    GradeDimension.first_or_create(sequence: 14, name: '22')

    puts '--- extract, transform, load salary reports ---'

    (1997..2018).each do |y|
      # if false
      time_dimension = TimeDimension.first_or_create(year: y)

      doc = Nokogiri::HTML.parse(open("./data/Average-Salary--#{y}.html"))
      rows = doc.xpath('//table/tbody/tr')
      details = rows.collect do |row|
        detail = {}
        [
          [:name, 'td[1]/a/text()'],
          [:code, 'td[2]/text()'],
          [:total, 'td[3]/text()'],
          [:average, 'td[4]/text()'],
          [:fte, 'td[5]/text()']
        ].each do |name, xpath|
          detail[name] = row.at_xpath(xpath).to_s.strip
        end
        detail[:year] = y
        detail
      end

      details.each do |d|
        name = d[:name]
        code = d[:code][0, 4]
        total = d[:total].gsub(/\D/, '').to_i
        average = d[:average].gsub(/\D/, '').to_i
        fte = d[:fte].to_i

        name = 'state total' if name.empty?

        district_dimension = DistrictDimension.first_or_create({ code: code }, name: name.downcase)
        SalaryFact.first_or_create(
          total: total,
          average: average,
          full_time_employees: fte,
          district_dimension: district_dimension,
          time_dimension: time_dimension
        )
      end
    end

    puts '--- now do enrollment ---'

    (2004..2019).each do |y|
      # if false
      t = TimeDimension.first_or_create(year: y)

      ext = 'xls'
      ext = 'xlsx' if y > 2013

      code_index = 1
      name_index = 2
      county_index = 3
      tally_index = 5

      if y == 2004 || y == 2005
        code_index = 2
        name_index = 3
        county_index = 0
        tally_index = 4
      end

      xl = Roo::Spreadsheet.open("./data/District-Grade--#{y}.#{ext}", extension: ext.to_sym)

      sheet = xl.sheet(0)

      (sheet.first_row..sheet.last_row).each do |i|
        code = sheet.cell(i, code_index)[0, 4] if sheet.cell(i, code_index)
        name = sheet.cell(i, name_index)
        county = sheet.cell(i, county_index)

        next unless code && name

        d = DistrictDimension.first_or_create({ code: code }, name: name, county: county)

        count = tally_index
        all = GradeDimension.all
        all.each do |g|
          if t.id && d.id && g.id
            enrollment = sheet.cell(i, count).to_i
            EnrollmentFact.first_or_create(
              time_dimension: t,
              district_dimension: d,
              grade_dimension: g,
              enrollment: enrollment
            )
          end

          count += 1
        end
      end
    end
  end
end
