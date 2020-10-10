defmodule DemoMacro do
  defmacro my_macro(number) do
    quote do
      unquote(number) * 10
    end
  end
end

defmodule Demo do
  require DemoMacro

  def run do
    DemoMacro.my_macro(2) |> IO.inspect
  end
end

Demo.run
