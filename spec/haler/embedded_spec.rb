require 'spec_helper'

describe Haler::Embedded do

  let(:embedded) { described_class.new }

  describe "#<<" do

    before do
      embedded << :some_resource
    end

    it "adds the resource" do
     embedded.should include :some_resource
    end

  end

  describe "#serialize" do

    let(:serialized) do
      embedded << :addresses
      embedded.serialize Person.new
    end

    let(:expected) do
      { addresses: [ Haler.decorate(Address.new).serialize ] }
    end

    it "serializes the embedded resource" do
      serialized.should eq expected
    end

  end

end
