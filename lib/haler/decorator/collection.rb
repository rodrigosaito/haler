module Haler

  module Decorator
    class Collection
      include Haler::Decorator

      def initialize(object, options = {})
        self.class.link :self do
          "/#{resource}"
        end

        @limit = options[:limit] || 10
        @offset = options[:offset] || 0

        super
      end

      def resource_name
        @object.name
      end

      def serialize
        super.tap do |serialized|
          to_serialize = @object.all(limit: @limit, offset: @offset)
          serialized[resource] = Haler.decorate(to_serialize).serialize
        end
      end

    end
  end

end
