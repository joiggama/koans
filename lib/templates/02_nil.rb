define "nil" do

  test "nil_is_an_object" do
    source <<-this
      assert_equal __, nil.is_a?(Object) # #{ t :hint }
    this
  end

  test "you_dont_get_null_pointer_errors" do
    source <<-this
      #{ t :hint }
      begin
        nil.#{ t :some_method_nil_doesnt_know }
      rescue StandardError => error
        # #{ t :hint_2 }
        assert_equal __, error.class

        #{ t :hint_3 }
        assert_match /__/, error.message
      end
    this
  end

  test "nil_has_a_few_methods_defined" do
    source <<-this
      assert_equal __, nil.nil?
      assert_equal __, nil.to_s
      assert_equal __, nil.inspect

      #{ t :hint }
    this
  end

end
