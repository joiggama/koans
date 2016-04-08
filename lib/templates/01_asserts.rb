define "asserts" do

  test "assert_truth" do
    source <<-this
      assert false # #{translate(:hint)}
    this
  end

  test "assert_with_message" do
    source <<-this
      assert false, "#{translate(:hint)}"
    this
  end

  test "assert_equality" do
    source <<-this
      #{translate(:expected_value)} = __(2)
      #{translate(:actual_value)} = 1 + 1

      assert #{translate(:expected_value)} == #{translate(:actual_value)}
    this
  end

  test "a_better_way_of_asserting_equality" do
    source <<-this
      #{translate(:expected_value)} = __(2)
      #{translate(:actual_value)} = 1 + 1

      assert_equal #{translate(:expected_value)}, #{translate(:actual_value)}
    this
  end

  test "fill_in_values" do
    source <<-this
      assert_equal __(2), 1 + 1
    this
  end

end
