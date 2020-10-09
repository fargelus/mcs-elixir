defmodule Typewriter do
  def start(filename) do
    printer = fn({contents, line_num}) ->
      IO.write "#{line_num + 1} "
      char_printer(contents)
    end

    File.stream!(filename) |>
    Stream.with_index |>
    Enum.each(printer)
  end

  defp char_printer(string) do
    string |> String.split("") |>
    Enum.each fn char ->
      :timer.sleep 100
      char |> IO.write
    end
  end
end

Typewriter.start 'typewriter.exs'
