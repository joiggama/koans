define "arrays" do

  test "creating_arrays" do
    source <<-this
      #{ t :empty_array } = Array.new

      assert_equal __, #{ t :empty_array }.class
      assert_equal __, #{ t :empty_array }.size
    this
  end

  test "array_literals" do
    source <<-this
      #{ t :array } = Array.new
      assert_equal [], #{ t :array }

      #{ t :array }[0] = 1
      assert_equal __, #{ t :array }

      #{ t :array }[1] = 2
      assert_equal [1, __], #{ t :array }

      #{ t :array } << 333
      assert_equal __, #{ t :array }
    this
  end

  test "accessing_array_elements" do
    source <<-this
      #{ t :array } = #{ t :elements }

      assert_equal __, #{ t :array }[0]
      assert_equal __, #{ t :array }.first
      assert_equal __, #{ t :array }[3]
      assert_equal __, #{ t :array }.last
      assert_equal __, #{ t :array }[-1]
      assert_equal __, #{ t :array }[-3]
    this
  end

  test "slicing_arrays" do
    source <<-this
      #{ t :array } = #{ t :elements }

      asssert_equal __, #{ t :array }[0, 1]
      asssert_equal __, #{ t :array }[0, 2]
      asssert_equal __, #{ t :array }[2, 2]
      asssert_equal __, #{ t :array }[2, 20]
      asssert_equal __, #{ t :array }[4, 0]
      asssert_equal __, #{ t :array }[4, 100]
      asssert_equal __, #{ t :array }[5, 0]
    this
  end

  test "arrays_and_ranges" do
    source <<-this
      assert_equal __, (1..5).class
      assert_equal __, (1..5)
      assert_equal __, (1..5).to_a
      assert_equal __, (1...5).to_a
    this
  end

  test "slicing_with_ranges" do
    source <<-this
      #{ t :array } = #{ t :elements }

      assert_equal __, #{ t :array }[0..2]
      assert_equal __, #{ t :array }[0...2]
      assert_equal __, #{ t :array }[2..-1]
    this
  end

  test "pushing_and_popping_arrays" do
    source <<-this
      #{ t :array } = [1, 2]

      assert_equal __, #{ t :array }

      #{ t :popped_value } = #{ t :array }.pop

      assert_equal __, #{ t :popped_value }
      assert_equal __, #{ t :array }
    this
  end

  test "shifting_arrays" do
    source <<-this
      #{ t :array } = [1, 2]
      #{ t :array }.unshift :#{ t :first }

      assert_equal __, #{ t :array }

      #{ t :shifted_value } = #{ t :array }.shift

      assert_equal __, #{ t :shifted_value }
      assert_equal __, #{ t :array }
    this
  end

end
