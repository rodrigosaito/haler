require "spec_helper"

describe Haler::Fields::Simple do

  class ToSerialize

    attr_accessor :name

    def initialize(name)
      @name = name
    end

  end

  let(:to_serialize) { ToSerialize.new "Some Name" }

  describe "#serialize" do

    context "when not pointing to another field" do

      let(:field) { described_class.new :name }

      it "serializes the name field" do
        field.serialize(to_serialize).should eq to_serialize.name
      end

    end

    context "when pointing to another field" do

      let(:field) { described_class.new :custom_name, { to: :name } }

      it "serialize the name field" do
        field.serialize(to_serialize).should eq to_serialize.name
      end

    end

  end

end
