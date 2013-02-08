require "spec_helper"

describe Haler::Decorator do

  let(:decorated) do
    PersonDecorator.new(Person.new)
  end

  describe Haler::Decorator::ClassMethods do

    class Klass
      include Haler::Decorator

      attr_accessor :id

      def initialize
        @id = 1
      end

    end

    let(:klass) do
      Klass
    end

    describe ".link" do

      before do
        klass.link :some_link do
          "/some-link"
        end
      end

      it "has defined link" do
        klass.links.should include :some_link
      end

    end

    describe ".embedded" do

      before do
        klass.embedded :some_resource
      end

      it "has defined embedded" do
        klass.embedded_collection.should include :some_resource
      end

    end

  end

  describe "#to_json" do

    let(:expected_json) do
      person_hash.to_json
    end

    it "serializes to json" do
      decorated.to_json.should == expected_json
    end
  end

  describe "delegate methods" do

    it "delegate methods to decorated class" do
      decorated.id.should == 1
    end

  end

  describe "#serialize" do

    let(:expected_hash) do
      person_hash
    end

    it "serializes to hash" do
      decorated.serialize.should == expected_hash
    end

  end

  describe "#resource" do

    it "returns the resource name" do
      decorated.resource.should eq "people"
    end

  end

  describe "after initialization" do

    it "has self link" do
      decorated.class.links.should include :self
    end

  end

end
