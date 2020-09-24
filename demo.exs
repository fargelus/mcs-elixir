defmodule Demo do
  def my_function(b) do
    (b + 2) |> mult |> division(0)
  end

  def mult(arg), do: arg * 2

  def division(arg, 0), do: "Infinity"

  def division(arg, d \\ 2), do: arg / d
end

Demo.my_function(3) |> IO.inspect
