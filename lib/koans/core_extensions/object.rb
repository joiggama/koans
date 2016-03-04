# Method name replacement.
class Object

  def ____(method=nil)
    if method
      self.send(method)
    end
  end

  in_ruby_version("1.9", "2") do
    public :method_missing
  end

end

