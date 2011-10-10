# Stolen from "Advanced Rails Recipes" :)
module ConstantCache
  module ClassMethods
    def caches_constants
      find(:all).each do |instance|
        attr_name = instance.respond_to?(:title) ? instance.title : instance.name
        const = attr_name.gsub(/\s+/, '_').upcase
        if const_defined?(const)
          raise RuntimeError, 
               "Constant #{self.to_s}::#{const} has already been defined"
        else
          const_set(const, instance)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:extend, ConstantCache::ClassMethods)