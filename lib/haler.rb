require "json"

require "active_support/inflector"

require "haler/version"
require "haler/fields"
require "haler/links"
require "haler/decorator"

module Haler

  # Finds the decorator class based on the class of the
  # object passed as parameter or use the option :decorator_class
  # if passed as option
  def self.decorate(object, options = {})
    decorator_class = from_options(options) ||
                      from_class_name(object) ||
                      from_interface(object) ||
                      from_type(object)
    decorator_class.new object
  end

  private
  def self.from_options(options)
    options[:decorator_class]
  end

  def self.from_class_name(object)
    begin
      Object::const_get("#{object.class}Decorator")
    rescue
      nil
    end
  end

  def self.from_interface(object)
    Haler::Decorator::Enumerator if object.respond_to? :each
  end

  def self.from_type(object)
    Haler::Decorator::Collection if object.is_a? Class
  end

end
