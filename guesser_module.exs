defmodule Guesser do
  def start do
    random = IO.gets("Enter limit number: ") |> Integer.parse |> random_number
    random |> IO.inspect
    IO.gets("Guess the number: ") |> Integer.parse |> check(random)
    exit(:shutdown)
  end

  def random_number({limit, _}), do: :rand.uniform(limit)

  def random_number(_) do
    IO.ANSI.red() <> "Please, enter valid number!" <> IO.ANSI.reset() |> IO.puts
    start()
  end

  def check({guess_number, _}, random) when guess_number == random do
    IO.ANSI.green() <> "You was right! The number was: #{random}" <> IO.ANSI.reset() |> IO.puts
  end

  def check({_, _}, random), do: IO.puts "You wrong. The number was #{random}"
end

Guesser.start
