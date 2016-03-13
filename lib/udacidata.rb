require_relative 'find_by'
require_relative 'errors'
require 'smarter_csv'
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
    products = Array.new
    CSV.foreach(@@file, headers: true) do |row|
      	products << new(id: row["id"], brand: row["brand"], name: row["product"],
                      price: row["price"])
    end
    products
  end

  def self.first(item = 1)
    item > 1 ? all.take(item) : all.first
  end

  def self.last(item = 1)
    item > 1 ? all.reverse.take(item) : all.reverse.first
  end
   
   def self.find(id)
      item = self.all.find {|item| item.id == id +1}
      return item
   end
end