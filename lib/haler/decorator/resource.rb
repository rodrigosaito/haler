module Haler

  module Decorator
    class Resource
      include Haler::Decorator

      def initialize(object, options = {})
        @options = options
        @limit = options[:limit] || 10
        @offset = options[:offset] || 0

        self.class.link :self do
          "/#{resource}"
        end

        self.class.link :next_page do |object|
          next_offset = @offset + @limit

          if object.count > next_offset
            "/#{resource}?limit=#{@limit}&offset=#{next_offset}"
          else
            nil
          end
        end

        self.class.link :prev_page do |object|
          prev_offset = @offset - @limit

          if prev_offset > 0
            "/#{resource}?limit=#{@limit}&offset=#{prev_offset}"
          else
            nil
          end
        end

        super
      end

      def resource_name
        @object.name
      end

      def serialize
        super.tap do |serialized|
          to_serialize = @object.all(limit: @limit, offset: @offset)

          serialized[resource.to_sym] = Haler.decorate(to_serialize, @options.merge({ person: { only_key_fields: true } })).serialize
        end
      end

    end
  end

end
