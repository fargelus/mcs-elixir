defmodule Demo do
  def if(arg) do
    if arg > 3, do: 'Greater than 3' |> IO.puts

    if arg > 3 do
      arg * 3 + 2
    else
      arg / 2 - 1
    end
  end

  def cond(arg) do
    cond do
      arg > 2 -> IO.puts "Greater"
      arg == 2 -> IO.puts "Equal"
      true -> IO.puts "Lesser"
    end
  end
end

Demo.if(5) |> IO.inspect
Demo.cond(5) |> IO.inspect
Demo.cond(0) |> IO.inspect
