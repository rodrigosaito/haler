require "spec_helper"

describe Haler::Navigator::Resource do

  let(:base_url) { "http://localhost:5000" }

  let(:described) { described_class.new base_url: base_url }

  around do |example|
    VCR.use_cassette("navigator/root_resource") do
      example.call
    end
  end

  shared_examples "only one request" do |method_name|
    it "issues only one request even when calling #{method_name} more than once" do
      described.send method_name
      described.send method_name
    end
  end

  describe "#new" do

    context "when only base_url is passed" do

      it "creates a new Resource with url == base_url" do
        described_class.new(base_url: base_url).url.should eq base_url
      end

      context "when base_url is nil" do

        it "raises an error" do
          expect {
            described_class.new(base_url: nil)
          }.to raise_error(Haler::Navigator::InvalidResourceOptionsError)
        end
      end

    end

    context "when base_url and path are passed" do

      it "creates a new Resource with url == base_url + path" do
        described_class.new(base_url: base_url, path: "/customers").url.should eq (base_url + "/customers")
      end
    end

    context "when base_url and hal_hash are passed" do

      it "creates a new Resource with url == base_url + :self link" do
        described_class.new(base_url: base_url, hal_hash: { _links: { self: { href: "/customers/1" } } }).url.should eq(base_url + "/customers/1")

      end

    end

  end

  describe "#links" do

    it "returns a Links object" do
      described.links.should be_a Haler::Navigator::Links
    end

    include_examples "only one request", :links

  end

  describe "#navigate_to" do

    let(:navigate_to) do
      described.navigate_to :customers
    end

    it "returns a Resource" do
      navigate_to.should be_a described_class
    end

    it "returns a Resource with base_uri pointing to resource" do
      navigate_to.url.should eq "http://localhost:5000/customers"
    end

    it "issues only one requrest even when calling navigate_to more than once" do
      described.navigate_to :customers
      described.navigate_to :customers
    end

  end

  describe "#attrs" do

    it "returns an Attributes object" do
      described.attrs.should be_a Haler::Navigator::Attributes
    end

    include_examples "only one request", :attrs

  end

  it "issues only one request" do
    # VCR would raise an error if more than one request is issued
    described.links
    described.navigate_to :customers
    described.attrs
  end

end

