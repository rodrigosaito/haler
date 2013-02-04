require 'spec_helper'

describe Haler do

  describe ".decorate" do

    context "when no options are passed" do

      let(:decorated) { Haler.decorate(Person.new) }

      it "returns an object of PersonDecorator" do
        decorated.should be_a PersonDecorator
      end

    end

    context "when decorator_class options is passed" do

      let(:decorated) { Haler.decorate(Person.new, decorator_class: CustomPersonDecorator) }

      it "return an object of CustomPersonDecorator" do
        decorated.should be_a CustomPersonDecorator
      end

    end

    context "when the object is an Enumerator" do

      let(:decorated) { Haler.decorate([ Person.new ]) }

      it "returns an object of Haler::Decorator::Enumerator" do
        decorated.should be_a Haler::Decorator::Enumerator
      end

    end

  end

end
