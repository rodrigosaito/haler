require 'spec_helper'
=begin
describe Haler::Links::Simple do

  let(:link) do
    described_class.new :self do
      '/some-link'
    end
  end

  describe "#serialize" do

    it "serializes the link" do
      link.serialize.should eq ({ href: '/some-link' })
    end

  end

  describe "#href" do

    it "returns the href for the link" do
      link.href.should eq "/some-link"
    end

  end

end
=end
