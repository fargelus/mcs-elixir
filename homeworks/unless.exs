defmodule MyModule do
  defmacro unless(condition, clauses) do
    quote do
      if unquote(condition) do
        unquote(Keyword.get clauses, :else, nil)
      else
        unquote(Keyword.get clauses, :do, nil)
      end
    end
  end
end

defmodule Test do
  require MyModule

  def start do
    MyModule.unless nil do
      true
    else
      false
    end
  end
end

Test.start |> IO.puts
