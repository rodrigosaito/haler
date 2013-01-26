module Haler

  module Links

    class Simple

      def initialize(rel, &block)
        @rel, @block = rel, block
      end

      def serialize
        { href: @block.call }
      end

    end

  end

end

