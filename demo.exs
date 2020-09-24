defmodule Demo do
  def my_function(b) do
    (b + 2) |> mult |> division(0)
  end

  def mult(arg), do: arg * 2

  def division(_, 0), do: "Infinity"
  def division(arg, d \\ 2), do: arg / d

  def fact(n) when n < 0 or not is_integer(n) do
    IO.puts("Wrong argument #{n}")
  end

  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)
end

Demo.my_function(3) |> IO.inspect
Demo.fact(5) |> IO.inspect
Demo.fact(-5) |> IO.inspect
Demo.fact('sdfsdfsdf') |> IO.inspect
