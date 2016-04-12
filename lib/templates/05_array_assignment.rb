Koans.define "array_assignment" do

  test "non_parallel_assignment" do
    source <<-this
      #{ t :names } = #{ t :elements }

      assert_equal __, #{ t :names }
    this
  end

  test "parallel_assignments" do
    source <<-this
      #{ t :first_name }, #{ t :last_name } = #{ t :names }

      assert_equal __, #{ t :first_name }
      assert_equal __, #{ t :last_name }
    this
  end

  test "parallel_assignments_with_extra_values" do
    source <<-this
      #{ t :first_name }, #{ t :last_name } = #{ t :names }

      assert_equal __, #{ t :first_name }
      assert_equal __, #{ t :last_name }
    this
  end

  test "parallel_assignments_with_splat_operator" do
    source <<-this
      #{ t :first_name }, *#{ t :last_name } = #{ t :names }

      assert_equal __, #{ t :first_name }
      assert_equal __, #{ t :last_name }
    this
  end

  test "parallel_assignments_with_too_few_variables" do
    source <<-this
      #{ t :first_name }, #{ t :last_name } = #{ t :names }

      assert_equal __, #{ t :first_name }
      assert_equal __, #{ t :last_name }
    this
  end

  test "parallel_assignments_with_subarrays" do
    source <<-this
      #{ t :first_name }, #{ t :last_name } = #{ t :names }

      assert_equal __, #{ t :first_name }
      assert_equal __, #{ t :last_name }
    this
  end

  test "swapping_with_parallel_assignment" do
    source <<-this
      #{ t :first_name } = #{ t(:names).first.inspect }
      #{ t :last_name } = #{ t(:names).last.inspect }

      #{ t :first_name }, #{ t :last_name } = #{ t :last_name }, #{ t :first_name }

      assert_equal __, #{ t :first_name }
      assert_equal __, #{ t :last_name }
    this
  end

end
