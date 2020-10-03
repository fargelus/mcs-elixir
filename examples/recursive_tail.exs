defmodule Demo do
  def fact(n), do: do_fact 1, n

  defp do_fact(total, 1), do: total
  defp do_fact(total, n) do
    do_fact total * n, n - 1
  end

  def mult(list), do: do_mult(1, list)

  defp do_mult(result, []), do: result  
  defp do_mult(result, [head | tail]) do
    do_mult result * head, tail
  end
end

Demo.fact(10000) |> IO.inspect
Demo.mult([1, 2, 3]) |> IO.inspect
