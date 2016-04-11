define "asserts" do

  test "assert_truth" do
    source <<-this
      assert false # #{ t :hint }
    this
  end

  test "assert_with_message" do
    source <<-this
      assert false, "#{ t :hint }"
    this
  end

  test "assert_equality" do
    source <<-this
      #{ t :expected_value } = __
      #{ t :actual_value } = 1 + 1

      assert #{ t :expected_value } == #{ t :actual_value }
    this
  end

  test "a_better_way_of_asserting_equality" do
    source <<-this
      #{ t :expected_value } = __
      #{ t :actual_value } = 1 + 1

      assert_equal #{ t :expected_value }, #{ t :actual_value }
    this
  end

  test "fill_in_values" do
    source <<-this
      assert_equal __, 1 + 1
    this
  end

end
