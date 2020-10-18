defmodule GuesserServer do
  def up do
    spawn(__MODULE__, :listen, [0]) |>
    Process.register(:guesser_server)
  end

  def listen(guessed_num) do
    guessed_num = receive do
      {:check, number, sender} ->
        result = if number == guessed_num, do: {:success}, else: {:error}
        send sender, result
        guessed_num

      {:put, number} -> number
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
    guessed_num = start_player.get_number("Enter limit number: ") |> check_limit(start_player)
                                                                  |> random

    send :guesser_server, {:put, guessed_num }
    [Mark: Enum.at(players, 0), Susan: Enum.at(players, 1)] |> process_move
  end

  defp check_limit(limit, player) do
    if limit <= 0 do
      player.get_number("Please enter the number > 0: ") |> check_limit(player)
    else
      limit
    end
  end

  defp random(limit) do
    num = :rand.uniform(limit)
    IO.puts "I set #{num}"
    num
  end

  defp process_move([next_player_info, prev_player_info]) do
    { next_player_name, next_player } = next_player_info
    number = next_player.get_number("#{next_player_name} guess the number: ")
    send :guesser_server, {:check, number, self()}

    receive do
      response ->
        case response do
          {:success} ->
            IO.ANSI.green() <> "#{next_player_name} was right! The number was: #{number}" <> IO.ANSI.reset()
            |> IO.puts
            next_player_name |> handle_exit
          {:error} ->
            {prev_player_name, _} = prev_player_info
            IO.puts("You wrong. Next turn by #{prev_player_name}")
            process_move([prev_player_info, next_player_info])
        end
    end
  end

  defp handle_exit(player_name) do
    answer = IO.gets "#{player_name} should restart the game(y)? "
    if String.match?(answer, ~r/y/i), do: start(), else: IO.puts "Bye. Hope to see you again"
  end
end

GuesserServer.up
GuesserGame.start
