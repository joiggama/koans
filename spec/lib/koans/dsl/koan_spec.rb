require "spec_helper"

RSpec.describe Koans::DSL::Koan do

  describe "#initialize" do
    it "assigns koan name" do
      koan = Koans::DSL::Koan.new("foo") {}
      expect(koan.name).to eq("foo")
    end

    it "assigns koan tests as empty array" do
      koan = Koans::DSL::Koan.new("foo") {}
      expect(koan.tests.count).to be_zero
    end
  end

  describe "#render" do
    it "returns the content for a fully valid ruby koan file" do
      I18n.backend.store_translations :testing,
        class_prefix: "About",
        test_prefix: "test",
        tests: {
          foo: {
            class: "Foo",
            something_truly_cool: {
              description: "This should be something truly cool",
              name: "something_truly_cool"
            }
          }
        }

      koan = Koans::DSL::Koan.new("foo") do
        test "something_truly_cool" do
          source <<-code
            assert true
          code
        end
      end

      expect(koan.render).to match %{

class AboutFoo < Neo::Koan

  # This should be something truly cool
  def test_something_truly_cool
    assert true
  end

end
      }.strip
    end
  end

  describe "#test" do
    it "appends a new test instance to tests" do
      koan = Koans::DSL::Koan.new("foo") {}
      expect {
        koan.test("bar") {}
      }.to change(koan.tests, :count).by(1)
    end
  end

  describe "#translate" do
    it "returns current locale value scoped to test context" do
      koan = Koans::DSL::Koan.new("foo") {}
      translations = { tests: { foo: { bar: "baz" }}}
      I18n.backend.store_translations(:testing, translations)
      expect(koan.translate(:bar)).to eq("baz")
    end
  end

end
