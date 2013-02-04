module Haler

  module Decorator

    class Enumerator

      def initialize(object)
        @object = object
      end

      def to_json
        [].tap do |array|
          @object.each do |item|
            array << Haler.decorate(item).serialize
          end
        end.to_json
      end

    end

  end

end
