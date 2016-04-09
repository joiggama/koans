define "objects" do

  test "everything_is_an_object" do
    source <<-this
      assert_equal __(true), 1.is_a?(Object)
      assert_equal __(true), 1.5.is_a?(Object)
      assert_equal __(true), "#{translate(:string)}".is_a?(Object)
      assert_equal __(true), nil.is_a?(Object)
      assert_equal __(true), Object.is_a?(Object)
    this
  end

  test "objects_can_be_converted_to_strings" do
    source <<-this
      assert_equal __("123"), 123.to_s
      assert_equal __(""), nil.to_s
    this
  end

  test "objects_can_be_inspected" do
    source <<-this
      assert_equal __("123"), 123.inspect
      assert_equal __("nil"), nil.inspect
    this
  end

  test "every_object_has_an_id" do
    source <<-this
      #{translate(:object)} = Object.new
      assert_equal __(Fixnum), #{translate(:object)}.object_id.class
    this
  end

  test "every_object_has_different_id" do
    source <<-this
      #{translate(:object)} = Object.new
      #{translate(:another_object)} = Object.new
      assert_equal __(true), #{translate(:object)}.object_id != #{translate(:another_object)}.object_id
    this
  end

  test "small_integers_have_fixed_ids" do
    source <<-this
      assert_equal __(1), 0.object_id
      assert_equal __(3), 1.object_id
      assert_equal __(5), 2.object_id
      assert_equal __(201), 100.object_id

      #{translate(:hint)}
    this
  end

  test "clone_creates_a_different_object" do
    source <<-this
      #{translate(:object)} = Object.new
      #{translate(:copy)} = #{translate(:object)}.clone

      assert_equal __(true), #{translate(:object)} != #{translate(:copy)}
      assert_equal __(true), #{translate(:object)}.object_id != #{translate(:copy)}.object_id
    this
  end

end
