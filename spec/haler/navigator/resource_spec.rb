require "spec_helper"

describe Haler::Navigator::Resource do

  let(:described) { described_class.new "http://localhost:5000" }

  describe "#links" do

    it "returns a Links object" do
      VCR.use_cassette("navigator/root_resource") do
        described.links.should be_a Haler::Navigator::Links
      end
    end

    it "issues only one call even when calling links more than once" do
      VCR.use_cassette("navigator/root_resource") do
        described.links
        described.links
      end
    end

  end

  describe "#navigate_to" do

    let(:navigate_to) do
      described.navigate_to :customers
    end

    it "returns a Resource" do
      VCR.use_cassette("navigator/root_resource") do
        navigate_to.should be_a described_class
      end
    end

    it "returns a Resource with base_uri pointing to resource" do
      VCR.use_cassette("navigator/root_resource") do
        navigate_to.url.should eq "http://localhost:5000/customers"
      end
    end

  end

end

