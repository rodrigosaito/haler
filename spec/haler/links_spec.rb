require 'spec_helper'

describe Haler::Links do

  describe Haler::Links::ClassMethods do

    class Klass
      include Haler::Links

      attr_accessor :id

      def initialize
        @id = 1
      end

    end

    let(:klass) do
      Klass
    end

    describe ".link" do

      before do
        klass.link :some_link do
          "/some-link"
        end
      end

      it "has defined link" do
        klass.links.should include :some_link
      end

    end

  end

end
