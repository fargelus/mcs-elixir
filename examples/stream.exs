defmodule Demo do
  def run(filename) do
    printer = fn({contents, line_num}) ->
      :timer.sleep 500
      IO.write "#{line_num + 1} #{contents}"
    end

    File.stream!(filename) |>
    Stream.with_index |>
    Enum.each(printer)
  end
end

Demo.run 'stream.exs'
