require 'spec_helper'

describe Haler::Links do

  let(:klass) do
    class Klass
      include Haler::Links
    end
  end

  before do
    klass.link :self do
      "/some-link"
    end
  end

  describe ".link" do

    it "has defined link" do
      klass.links.should include :self
    end

  end

end
