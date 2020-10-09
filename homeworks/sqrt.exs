defmodule Functions do
  def all?(list), do: all?(list, &(!!&1))
  def all?([], _predicate), do: true
  def all?([head|tail], predicate) do
    result = predicate.(head)
    if result, do: all?(tail, predicate), else: false
  end
end

defmodule Sqrt do
  import Functions

  def gen_table(range) do
    list = Enum.to_list range
    cond do
      all?(list, &(is_integer(&1))) -> calculate_squares(list)
      true -> raise ArgumentError, message: "Should be all numbers in range"
    end
  end

  defp calculate_squares(list) do
    for x <- list, into: %{} do
      {x, :math.sqrt(x)}
    end
  end
end

squares = Sqrt.gen_table(1..10)
squares[3] |> IO.puts
