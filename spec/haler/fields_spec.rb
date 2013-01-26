require 'spec_helper'

describe Haler::Fields do

  let(:klass) do
    class Klass
      include Haler::Fields
    end
  end

  describe ".field" do

    context "when only name is provided" do

      before do
        klass.field :name
      end

      it "has the field :name" do
        klass.fields.should include :name
      end

    end

    context "when :to option is passed" do

      before do
        klass.field :custom_name, to: :name
      end

      it "has the field custom_name" do
        klass.fields.should include :custom_name
      end

      it "points to name field" do
        klass.fields[:custom_name].to.should eq :name
      end

    end

  end

end
