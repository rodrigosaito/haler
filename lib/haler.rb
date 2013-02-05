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
    begin
      decorator_class = options[:decorator_class] || Object::const_get("#{object.class}Decorator")
    rescue NameError
      raise unless object.respond_to? :each
      decorator_class = Haler::Decorator::Enumerator
    end
    decorator_class.new object
  end

end
