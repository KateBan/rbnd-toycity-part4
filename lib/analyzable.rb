module Analyzable

	def average_price(products)
		total = 0.0
		products.each do |product| 
			total += product.price.to_f
		end
		(total/products.length).round(2)
	end
  
  def print_report(products)
  end
 
end
