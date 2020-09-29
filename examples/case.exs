defmodule Demo do
  def case(file) do
    printer = fn(line) ->
      :timer.sleep 500
      IO.puts line
    end

    case File.read(file) do
      {:ok, content} ->
        content |> String.split("\n") |> Enum.each(printer)

      {:error, reason} -> IO.puts "Error! #{reason}"
    end
  end
end

Demo.case('./case.exs')
