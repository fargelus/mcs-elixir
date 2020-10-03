defmodule Demo do
  def traverse([]), do: :ok

  def traverse([head | tail]) do
    head |> IO.puts
    tail |> traverse
  end

  def map([], cb), do: []

  def map([head | tail], cb) do
    [cb.(head) | map(tail, cb)]
  end

  def mult([]), do: 1

  def mult([head|tail]) do
    head * mult(tail)
  end
end

Demo.traverse([1, 2, 3, 4, 5])
Demo.map([1, 2, 3], &(&1 * 2)) |> Demo.mult |> IO.inspect
Demo.mult([1, 2, 3]) |> IO.inspect
