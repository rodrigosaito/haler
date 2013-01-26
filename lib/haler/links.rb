require 'haler/links/simple'

module Haler

  module Links

    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods

      def link(rel, &block)
        links[rel] = Simple.new(rel, &block)
      end

      def links
        @links ||= {}
      end

      def has_links?
        not links.empty?
      end

    end

  end

end
