module Haler

  module Decorator
    class Collection
      include Haler::Decorator

      def initialize(object, options = {})
        self.class.link :self do
          "/#{resource}"
        end

        super
      end

      def resource_name
        @object.name
      end

      def serialize
        super.tap do |serialized|
          serialized[resource] = Haler.decorate(@object.all).serialize
        end
      end

    end
  end

end
