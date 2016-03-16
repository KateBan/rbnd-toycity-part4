require_relative 'find_by'
require_relative 'errors'
require_relative 'product'
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
  				row << create_item
  			end
  		end
  	end
  	item
  end


 def self.all
    products = Array.new
    CSV.foreach(@@file, headers: true) do |row|
      	products << new(id: row["id"], brand: row["brand"], name: row["product"], price: row["price"])
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
    item = self.all.find{|item| item.id == id}
    if !item
      raise UdacidataErrors::ProductNotFoundError, "There is not a product with id: #{id}."
    end
    item
  end

  # Very useful link on how to delete a CSV row in Ruby
  # And why you should use CSV.table and not CSV.read
  # http://stackoverflow.com/questions/26707169/how-to-remove-a-row-from-a-csv-with-ruby
  def self.destroy(id)
    item = find(id)
    table = CSV.table(@@file)
    table.delete_if {|row| row[:id] == id}
    
    File.open(@@file, 'w') do |f|
      f.write(table.to_csv)
    end
    item
  end

  def self.where(options = {})
    items = self.all
    options.each do |key,value|
      items = items.select {|item| item.send(key) == value} 
    end
    items
  end
 
  def update(options = {})
    Product.destroy(id)
    updated_brand = options[:brand] ? options[:brand] : brand
    updated_name = options[:name] ? options[:name] : name
    updated_price = options[:price] ? options[:price] : price
    Product.create(id: id, brand: updated_brand, name: updated_name, price: updated_price)
  end
end



