class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |n|
      getter = n.to_s
      setter = n.to_s + "="

      define_method(getter){
        self.instance_variable_get(n)
      }
      
      define_method(setter){
        self.instance_variable_set(n, arg)
      }
    end
  end
end
