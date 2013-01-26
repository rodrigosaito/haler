require 'spec_helper'

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

end
