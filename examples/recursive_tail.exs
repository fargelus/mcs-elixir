# iex recursive_tail.exs

defmodule Demo do
  def work(i) do
    spawn (fn ->
      fact(10) |> IO.inspect(label: "#{i} Result is")
    end) |> IO.inspect
  end

  def calc_fact_by_processes do
    Enum.each 1..5, &(work(&1))
  end

  def fact(n) do
    :timer.sleep 5000
    do_fact 1, n
  end

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

Demo.mult([1, 2, 3]) |> IO.inspect
Demo.calc_fact_by_processes
IO.puts "Other work"
