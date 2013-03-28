require "spec_helper"

describe Haler::Navigator::EntryPoint do

  let(:base_uri) { "http://some-server:4567" }

  let(:some_resource_uri) { base_uri + "/some_resource" }

  let(:described) { described_class.new base_uri }

  describe "#links" do

    it "returns a Links object" do
      pending
      VCR.use_cassette("navigator/links") do
        described.links.should be_a Haler::Navigator::Links
      end
    end

    it "returns a list of links" do
      pending
      VCR.use_cassette("navigator/links") do
        described.links.keys.should eq [:self, :some_resource ]
      end
    end

    it "issues only one call even when calling links more than once" do
      pending
      VCR.use_cassette("navigator/links") do
        described.links
        described.links
      end
    end

  end

  describe "#navigate_to" do

    let(:navigate_to) do
      described.navigate_to :some_resource
    end

    it "returns an EntryPoint" do
      pending
      VCR.use_cassette("navigator/links") do
        navigate_to.should be_a described_class
      end
    end

    it "returns an EntryPoint with base_uri pointing to resource" do
      pending
      VCR.use_cassette("navigator/links") do
        navigate_to.base_uri.should eq some_resource_uri
      end
    end

  end

  describe "#attrs" do

    it "returns an Attributes object" do
      pending
      VCR.use_cassette("navigator/links") do
        described.attrs.should be_a Haler::Navigator::Attributes
      end
    end

  end

  it "issues only one request" do
    pending
    # VCR would raise an error if more than one request is issued
    VCR.use_cassette("navigator/links") do
      described.links
      described.navigate_to :some_resource
      described.attrs
    end
  end

end
