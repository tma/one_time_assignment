module OneTimeAssignment
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def allow_one_time_assignment(*attribute_names)
      attribute_names.map(&:to_sym).each do |attribute_name|
        define_method("#{attribute_name}=") do |value|
          if self.send(attribute_name).blank?
            write_attribute(attribute_name, value)
          else
            raise "#{attribute_name.to_s.humanize} is already set!"
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, OneTimeAssignment
