defmodule GuesserServer do
  def up(number) do
    spawn(__MODULE__, :listen, [number]) |>
    Process.register(:guesser_server)
  end

  def listen(guessed_num) do
    receive do
      {:check, number, sender} ->
        result = if number == guessed_num, do: {:success}, else: {:error}
        send sender, result
    end
    listen(guessed_num)
  end
end

defmodule Guesser do
  def get_number(msg) do
    IO.gets(msg) |> Integer.parse |> to_int
  end

  defp to_int(arg) do
    case arg do
      {number, _} -> number
      _ -> get_number("Please enter the valid number: ")
    end
  end
end

defmodule GuesserGame do
  def start do
    players = [Guesser, Guesser]
    start_player = Enum.random(players)
    start_player.get_number("Enter limit number: ") |> check_limit(start_player)
                                                    |> random |> GuesserServer.up

    process_move(players)
  end

  defp check_limit(limit, player) do
    unless limit > 0 do
      player.get_number("Please enter the valid number: ") |> check_limit(player)
    end
    limit
  end

  defp random(limit) do
    num = :rand.uniform(limit)
    IO.puts "I set #{num}"
    num
  end

  defp process_move([next_player, prev_player]) do
    number = next_player.get_number("Guess the number: ")
    send :guesser_server, {:check, number, self()}

    receive do
      response ->
        case response do
          {:success} ->
            IO.ANSI.green() <> "You was right! The number was: #{number}" <> IO.ANSI.reset()
            |> IO.puts
          {:error} ->
            IO.puts("You wrong. Next turn")
            process_move([prev_player, next_player])
        end
    end
  end
end

GuesserGame.start
