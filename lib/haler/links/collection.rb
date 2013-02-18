#require 'haler/links/simple'

module Haler

  module Links

    # Class that holds all the logic for links creation and serialization
    class Collection


      def initialize
        @links = {}
      end

      def <<(rel, &block)
        raise "Block not given, add method expects a block" unless block_given?
        @links[rel] = block
      end

      def method_missing(method, *args, &block)
        if @links.respond_to? method
          @links.send(method, *args, &block)
        else
          super
        end
      end

      def serialize(object)
        {}.tap do |serialized|
          @links.each_pair do |rel, link_proc|
            href = link_proc.call(object)
            if href
              serialized[rel] = {
                href: link_proc.call(object)
              }
            end
          end
        end
      end

    end
  end

end
