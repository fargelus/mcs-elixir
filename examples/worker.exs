defmodule Worker do
  def work do
    IO.puts "Worker..."
    receive do
      {:add, a, b, sender} -> send sender, a + b
      _ -> IO.puts "Not sure how to process this message..."
    end
    IO.puts "Ending worker..."
  end
end

defmodule Demo do
  def run do
    pid = spawn Worker, :work, []
    send pid, {:add, 1, 2, self()}

    response = receive do
      response -> response
    end
    response |> IO.inspect(label: "Response is")
  end
end

Demo.run
