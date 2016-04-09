define "arrays" do

  test "creating_arrays" do
    source <<-this
      #{ translate :empty_array } = Array.new

      assert_equal __, #{ translate :empty_array }.class
      assert_equal __, #{ translate :empty_array }.size
    this
  end

  test "array_literals" do
    source <<-this
      #{ translate :array } = Array.new
      assert_equal [], #{ translate :array }

      #{ translate :array }[0] = 1
      assert_equal __, #{ translate :array }

      #{ translate :array }[1] = 2
      assert_equal [1, __], #{ translate :array }

      #{ translate :array } << 333
      assert_equal __, #{ translate :array }
    this
  end

  test "accessing_array_elements" do
    source <<-this
      #{ translate :array } = #{ translate :elements }

      assert_equal __, #{ translate :array }[0]
      assert_equal __, #{ translate :array }.first
      assert_equal __, #{ translate :array }[3]
      assert_equal __, #{ translate :array }.last
      assert_equal __, #{ translate :array }[-1]
      assert_equal __, #{ translate :array }[-3]
    this
  end

  test "slicing_arrays" do
    source <<-this
      #{ translate :array } = #{ translate :elements }

      asssert_equal __, #{ translate :array }[0, 1]
      asssert_equal __, #{ translate :array }[0, 2]
      asssert_equal __, #{ translate :array }[2, 2]
      asssert_equal __, #{ translate :array }[2, 20]
      asssert_equal __, #{ translate :array }[4, 0]
      asssert_equal __, #{ translate :array }[4, 100]
      asssert_equal __, #{ translate :array }[5, 0]
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
      #{ translate :array } = #{ translate :elements }

      assert_equal __, #{ translate :array }[0..2]
      assert_equal __, #{ translate :array }[0...2]
      assert_equal __, #{ translate :array }[2..-1]
    this
  end

  test "pushing_and_popping_arrays" do
    source <<-this
      #{ translate :array } = [1, 2]

      assert_equal __, #{ translate :array }

      #{ translate :popped_value } = #{ translate :array }.pop

      assert_equal __, #{ translate :popped_value }
      assert_equal __, #{ translate :array }
    this
  end

  test "shifting_arrays" do
    source <<-this
      #{ translate :array } = [1, 2]
      #{ translate :array }.unshift :#{ translate :first }

      assert_equal __, #{ translate :array }

      #{ translate :shifted_value } = #{ translate :array }.shift

      assert_equal __, #{ translate :shifted_value }
      assert_equal __, #{ translate :array }
    this
  end

end
