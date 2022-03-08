class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |n|
      getter = n.to_s
      setter = n.to_s + "="

      define_method(getter){
        self.instance_variable_get("@" + n.to_s)
      }
      
      define_method(setter){ |arg|
        self.instance_variable_set("@" + n.to_s, arg)
      }
    end
  end
end
