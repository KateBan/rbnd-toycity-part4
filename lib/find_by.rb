class Module
  def create_finder_methods(*attributes)
  	attributes.each do |attribute|
  		finder_method = %Q{
        			def find_by_#{attribute}(arg)
          				return self.all.find {|item| item.#{attribute} == arg}
        			end
      				}
      	class_eval(finder_method)
      end
  end
end

Module.create_finder_methods('brand', 'name')

