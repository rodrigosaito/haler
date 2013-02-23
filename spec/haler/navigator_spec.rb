require 'spec_helper'

describe Haler::Navigator do

  describe ".entry_point" do

    it "returns an EntryPoint object" do
      described_class.entry_point("http://some-server.com/").should be_a Haler::Navigator::EntryPoint
    end

  end


end
