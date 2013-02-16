require 'spec_helper'

describe Haler::Links do

  let(:links) { described_class.new }

  before do
    links.<<(:self) do |object|
      "/some-link/#{object.id}"
    end
  end

  describe "#<<" do

    it "adds the link" do
      links.should include :self
    end

    it "adds proc as value for link" do
      links[:self].should be_a Proc
    end

    context "when block is not provided" do

      it "raises an error" do
        expect {
          links.<<(:test)
        }.to raise_error
      end
    end

  end

  describe "#serialize" do

    let(:expected) do
      { self: { href: "/some-link/1" } }
    end

    it "serializes all links" do
      links.serialize(Person.new).should eq expected
    end

    context "when link block returns nil" do

      before do
        links.<<(:nil_link) do
          nil
        end
      end

      it "hides the link" do
        links.serialize(Person.new).should_not include :nil_link
      end
    end

  end

end
