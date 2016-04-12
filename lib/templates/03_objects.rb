Koans.define "objects" do

  test "everything_is_an_object" do
    source <<-this
      assert_equal __, 1.is_a?(Object)
      assert_equal __, 1.5.is_a?(Object)
      assert_equal __, "#{ t :string }".is_a?(Object)
      assert_equal __, nil.is_a?(Object)
      assert_equal __, Object.is_a?(Object)
    this
  end

  test "objects_can_be_converted_to_strings" do
    source <<-this
      assert_equal __, 123.to_s
      assert_equal __, nil.to_s
    this
  end

  test "objects_can_be_inspected" do
    source <<-this
      assert_equal __, 123.inspect
      assert_equal __, nil.inspect
    this
  end

  test "every_object_has_an_id" do
    source <<-this
      #{ t :object } = Object.new
      assert_equal __, #{ t :object }.object_id.class
    this
  end

  test "every_object_has_different_id" do
    source <<-this
      #{ t :object } = Object.new
      #{ t :another_object } = Object.new
      assert_equal __, #{ t :object }.object_id != #{ t :another_object }.object_id
    this
  end

  test "small_integers_have_fixed_ids" do
    source <<-this
      assert_equal __, 0.object_id
      assert_equal __, 1.object_id
      assert_equal __, 2.object_id
      assert_equal __, 100.object_id

      #{ t :hint }
    this
  end

  test "clone_creates_a_different_object" do
    source <<-this
      #{ t :object } = Object.new
      #{ t :copy } = #{ t :object }.clone

      assert_equal __, #{ t :object } != #{ t :copy }
      assert_equal __, #{ t :object }.object_id != #{ t :copy }.object_id
    this
  end

end
