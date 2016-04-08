define "nil" do

  test "nil_is_an_object" do
    source <<-this
      assert_equal __(true), nil.is_a?(Object) # #{translate(:hint)}
    this
  end

  test "you_dont_get_null_pointer_errors" do
    source <<-this
      #{translate(:hint)}
      begin
        nil.#{translate(:some_method_nil_doesnt_know)}
      rescue StandardError => error
        # #{translate(:hint_2)}
        assert_equal __(NoMethodError), error.class

        #{translate(:hint_3)}
        assert_match /#{__("undefined_method")}/, error.message
      end
    this
  end

  test "nil_has_a_few_methods_defined" do
    source <<-this
      assert_equal __(true), nil.nil?
      assert_equal __(""), nil.to_s
      assert_equal __("nil"), nil.inspect

      #{translate(:hint)}
    this
  end

end
