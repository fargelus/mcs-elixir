defmodule Guesser do
  def start do
    rand = read_input("Enter limit number: ") |> random
    read_input("Guess the number: ") |> check(rand)
  end

  defp read_input(msg) do
    IO.gets(msg) |> Integer.parse |> to_int
  end

  defp to_int(arg) do
    case arg do
      {number, _} -> number
      _ -> read_input("Please enter the valid number: ")
    end
  end

  defp error(msg) do
    IO.ANSI.red() <> msg <> IO.ANSI.reset() |> IO.puts
  end

  defp random(limit) when limit > 0 do
    num = :rand.uniform(limit)
    IO.puts "I set #{num}"
    num
  end

  defp random(_) do
    error("Please enter an integer number greater than 0")
    read_input("Enter limit number: ") |> random()
  end

  defp check(number, number) do
    IO.ANSI.green() <> "You was right! The number was: #{number}" <> IO.ANSI.reset() |> IO.puts
  end

  defp check(number, rand), do: error("You wrong. You entered #{number}, but the number was #{rand}")
end

Guesser.start
