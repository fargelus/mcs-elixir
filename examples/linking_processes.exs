defmodule Worker do
  def work do
    IO.puts "Worker..."

    receive do
      {:div, a, b} -> do_div(a, b)
      _ -> IO.puts "Not sure how to process this message..."
    end
  end

  defp do_div(a, 0), do: exit(:error)
  defp do_div(a, b), do: a / b
end

defmodule Demo do
  def run do
    Process.flag :trap_exit, true
    pid = spawn_link Worker, :work, []
    send pid, {:div, 5, 0}

    receive do
      response -> response |> IO.inspect
    after 5000 -> IO.puts "timeout"
    end

    IO.puts "Doing other stuff..."
  end
end

Demo.run
