defimpl String.Chars, for: Map do
  def to_string(term) do
    term |> Map.keys |> Enum.join(", ")
  end
end

%{test: 1} |> IO.puts
