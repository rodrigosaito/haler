module Haler

  module Decorator

    class Enumerator

      def initialize(object, options = {})
        @object = object
        @options = options
      end

      def to_json
        serialize.to_json
      end

      def serialize
        [].tap do |array|
          @object.each do |item|
            options = @options[item.class.name.camelize(:lower).to_sym] || {}

            array << Haler.decorate(item, options).serialize
          end
        end
      end

    end

  end

end
