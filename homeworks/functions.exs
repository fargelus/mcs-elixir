defmodule Functions do
  def span(start, start), do: [start]
  def span(start, last) do
    next = if start > last, do: start - 1, else: start + 1
    [start | span(next, last)]
  end

  def max_num(a, b), do: if a > b, do: a, else: b
  def max_num(list) when length(list) == 1, do: hd list
  def max_num([head|tail]) do
    [tail_head | other] = tail
    maximum = max_num(head, tail_head)
    max_num([maximum | other])
  end

  def all?([], predicate), do: true
  def all?(list), do: all?(list, &(!!&1))
  def all?([head|tail], predicate) do
    result = predicate.(head)
    if result, do: all?(tail, predicate), else: false
  end
end

Functions.span(10, 1) |> IO.inspect
Functions.span(1, 10) |> IO.inspect

Functions.max_num([1, 30, 20, 5]) |> IO.inspect
Functions.max_num([1000]) |> IO.inspect

Functions.all?([1, 2, -5, 0], &( &1 > 0 )) |> IO.inspect
Functions.all?([1, 2, 5, 10], &( &1 > 0 )) |> IO.inspect
Functions.all?([1, 2, 3, 4, 10]) |> IO.inspect
Functions.all?([1, 2, false, 4, 10]) |> IO.inspect
