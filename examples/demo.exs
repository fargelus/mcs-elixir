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

  def run(list) do
    printer = fn
      {name, number} ->
        "#{name} is #{number}" |> IO.puts

      str ->
        str |> IO.puts

      _ -> # fallback
        IO.puts "fallback"
    end

    #Enum.each list, fn(str) -> str |> IO.inspect end
    Enum.each list, printer
  end

  def short_run(list) do
    Enum.each list, &( IO.inspect(&1 * &1) )
  end

  def shortest_run(list) do
    Enum.each list, &IO.inspect/1
  end
end

Demo.my_function(3) |> IO.inspect

Demo.fact(5) |> IO.inspect
Demo.fact(-5) |> IO.inspect
Demo.fact('sdfsdfsdf') |> IO.inspect

Demo.run [1, 2, 3, 4, 5]
Demo.run [{:a, 1}, {:b, 2}, {:c, 3}, {:d, 4}, {:e, 5}]

Demo.short_run [5, 4, 3, 2, 1]
Demo.shortest_run [5, 4, 3, 2, 1]
