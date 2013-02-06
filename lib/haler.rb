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
    decorator_class = DecoratorFinder.new(object, options).find_class
    decorator_class.new object
  end

  class DecoratorFinder

    def initialize(object, options = {})
      @object, @options = object, options
    end

    def find_class
      from_options ||
        from_class_name ||
        from_type ||
        from_interface
    end

    private
    def from_options
      @options[:decorator_class]
    end

    def from_class_name
      begin
        Object::const_get("#{@object.class}Decorator")
      rescue
        nil
      end
    end

    def from_interface
      Haler::Decorator::Enumerator if @object.respond_to? :each
    end

    def from_type
      Haler::Decorator::Collection if @object.is_a? Class
    end

  end

end
