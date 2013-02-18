require 'spec_helper'

describe Haler::Embedded do

  describe Haler::Embedded::ClassMethods do
    class Klass
      include Haler::Embedded

      attr_accessor :id

      def initialize
        @id = 1
      end

    end

    let(:klass) do
      Klass
    end

    describe ".embedded" do

      before do
        klass.embedded :some_resource
      end

      it "has defined embedded" do
        klass.embedded_collection.should include :some_resource
      end

    end

  end

end