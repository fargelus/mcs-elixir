defmodule Demo do
  def traverse([]), do: :ok

  def traverse([head | tail]) do
    head |> IO.puts
    tail |> traverse
  end

  def map([head | tail], cb) do
    [map(head, cb) | map(tail, cb)]
  end

  def map(element, cb), do: cb.(element)
end

Demo.traverse([1, 2, 3, 4, 5])
Demo.map([1, 2, 3], &IO.puts/1)
