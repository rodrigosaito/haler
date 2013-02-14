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
          serialized[:_links].tap do |links|
            links[:next_page] = { href: next_page_link } if next_page?
            links[:prev_page] = { href: prev_page_link } if prev_page?
          end

          to_serialize = @object.all(limit: @limit, offset: @offset)
          serialized[resource.to_sym] = Haler.decorate(to_serialize).serialize
        end
      end

      private
      def next_offset
        @offset + @limit
      end

      def prev_offset
        @offset - @limit
      end

      def next_page_link
        "/#{resource}?limit=#{@limit}&offset=#{next_offset}"
      end

      def prev_page_link
        "/#{resource}?limit=#{@limit}&offset=#{prev_offset}"
      end

      def next_page?
        @object.count > next_offset
      end

      def prev_page?
        prev_offset > 0
      end

    end
  end

end
