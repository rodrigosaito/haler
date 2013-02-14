module Haler

  module Decorator

    class Enumerator

      def initialize(object, options = {})
        @object = object
      end

      def to_json
        serialize.to_json
      end

      def serialize
        [].tap do |array|
          @object.each do |item|
            array << Haler.decorate(item).serialize
          end
        end
      end

    end

  end

end
