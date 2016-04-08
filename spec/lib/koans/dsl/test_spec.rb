require "spec_helper"

RSpec.describe Koans::DSL::Test do

  describe "#initialize" do
    it "assigns koan name" do
      test = Koans::DSL::Test.new "foo", "bar" do ; end
      expect(test.koan).to eq("foo")
    end

    it "assigns test name" do
      test = Koans::DSL::Test.new "foo", "bar" do ; end
      expect(test.name).to eq("bar")
    end

    it "assigns test source as empty" do
      test = Koans::DSL::Test.new "foo", "bar" do ; end
      expect(test.source).to be_empty
    end

    it "evaluates a given block" do
      evaluated = nil
      expect {
        Koans::DSL::Test.new("foo", "bar") { evaluated = true }
      }.to change { evaluated }.to true
    end
  end

  describe "#has?" do
    context "when attribute is defined in translations" do
      it "returns true" do
        translation = { tests: { foo: { bar: { existing_attr: "baz" } } } }
        I18n.backend.store_translations :testing, translation
        test = Koans::DSL::Test.new "foo", "bar" do ; end
        expect(test.has?(:existing_attr)).to be_truthy
      end
    end

    context "when attribute isn't defined in translations" do
      it "returns false" do
        test = Koans::DSL::Test.new "foo", "bar" do ; end
        expect(test.has?(:unexisting_attr)).to be_falsey
      end
    end
  end

  describe "#source" do
    context "with an argument" do
      it "appends it to @source" do
        test = Koans::DSL::Test.new "foo", "bar" do ; end
        expect(test.source).to be_empty
        expect {
          test.source <<-code
            something
          code
        }.to change(test, :source).from("").to include("something")
      end
    end

    context "without arguments" do
      it "returns @source contents" do
        test = Koans::DSL::Test.new "foo", "bar" do ; end
        expect(test.source).to eq("")
      end
    end
  end

  describe "#translate" do
    it "returns current locale value scoped to test context" do
      translation = { tests: { foo: { bar: { description: "baz" } } } }
      I18n.backend.store_translations :testing, translation

      test = Koans::DSL::Test.new "foo", "bar" do ; end
      expect(test.translate("description")).to eq("baz")
    end
  end

end
