module Analyzable

   def average_price(products)
	 total = 0.0
	 products.each do |product| 
		total += product.price.to_f
	end
	(total/products.length).round(2)
   end
  
  # count_by_brand and count_by_name need some refactoring 
  def count_by_brand(products)
  	inventory = Hash.new 0
  	products.each { |product| inventory[product.brand] += 1}	
  	inventory
  end

  def count_by_name(products)
  	inventory = Hash.new 0
    products.each { |product| inventory[product.name] += 1}  
    inventory
  end

  def print_report(products)
  	report = "Average Price: $#{average_price(products)}\n"
  	report += "Inventory by Brand: \n"
  	count_by_brand(products).each do |brand, value|
  		report += "    - #{brand}: #{value}\n"
  	end
  	report += "Inventory by Name: \n"
  	count_by_name(products).each do |name, value|
  		report += "    - #{name}: #{value}\n"
  	end
  	report
  end
 
end
