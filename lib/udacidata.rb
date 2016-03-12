require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@file = File.dirname(__FILE__) + "/../data/data.csv"
  
  def self.create(*attributes)
  	data = CSV.read(@@file)
  	item = self.new(*attributes)

  	if item.is_a? Product
  		create_item = [item.id, item.brand, item.name, item.price]
  		if !data.include?(create_item)
  			CSV.open(@@file, "ab") do |row|
  				row << data
  			end
  		end
  	end
  	item
  end

  def self.all
  	products =[]
  	
  end
end
