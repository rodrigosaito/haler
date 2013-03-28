require 'haler/embedded/collection'

module Haler

  module Embedded

    def self.included(base)
      base.class_eval do
        extend ClassMethods

      end
    end

    module ClassMethods

      def embedded(res_name)
        embedded_collection.<<(res_name, { res_name.to_s.singularize.to_sym => { only_key_fields: true }})
      end

      def embedded_collection
        @embedded_collection ||= Embedded::Collection.new
      end

    end

  end

end
