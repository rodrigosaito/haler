module Haler

  module Fields

    class Simple

      attr_accessor :name

      def to
        @options[:to]
      end

      def initialize(name, options = {})
        @name, @options = name, options
      end

      def serialize(object)
        return object.send to if to
        object.send @name
      end

    end

  end

end
