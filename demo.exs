defmodule Demo do
  def my_function(b) do
    (b + 2) |> mult |> div
  end

  def mult(arg), do: arg * 2  

  def div(arg), do: arg / 2
end

Demo.my_function(3) |> IO.inspect
