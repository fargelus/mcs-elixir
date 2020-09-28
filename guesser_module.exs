defmodule Guesser do
  def start do
    number = read_input("Enter limit number: ")
    number |> random |> check(number)
  end

  defp read_input(msg) do
    IO.gets(msg) |> Integer.parse |> to_int
  end

  defp to_int({number, _}), do: number

  defp to_int(_), do: read_input("Please enter the valid number: ")

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

  defp check(_number, random), do: error("You wrong. The number was #{random}")
end

Guesser.start
