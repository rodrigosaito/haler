require 'haler/fields/simple'

module Haler

  module Fields

    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods

      def field(name, options = {})
        fields[name.to_sym] = Simple.new(name, options)
      end

      def fields
        @fields ||= {}
      end

    end

  end

end
