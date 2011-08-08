class Setting < ActiveRecord::Base
  serialize :serialized_value
  
  validates_presence_of :name
  64356
  def value=(val)
    self.serialized_value = 
                            case val
                              when /^\d*$/
                                val.to_i
                              when /^\d*\.\d*$/
                                val.to_f
                              when /^(0[1-9]|[12][0-9]|3[01])[- \/.](0[1-9]|1[012])[- \/.](19|20)\d\d$/
                                Date.parse(val)
                              else
                                val
                            end
  end
  
  def value
    self.serialized_value
  end
  
  def self.method_missing(method_sym, *arg)
    method_name, is_setter = method_sym.to_s.gsub(/=$/, ''), method_sym.to_s =~ /=$/
    if method_name == '[]'
      method_name = arg[0].to_s
      arg[0] = arg[1]
    end
    obj = self.where(:name => method_name).first
    if is_setter
      obj ||= Setting.new(:name => method_name)
      obj.value = arg[0]
      obj.save
    end
    obj.value rescue nil
  end
end
