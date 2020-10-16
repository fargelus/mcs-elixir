defmodule Pebbles.Server do
  def start do
    spawn(__MODULE__, :listen, [10]) |>
    Process.register(:pebbles_server)
  end

  def listen(pebbles_count) do
    pebbles_left = receive do
      {:get, sender} ->
        result = perform(pebbles_count)
        send sender, result
        pebbles_count - (elem result, 1)
    end

    listen(pebbles_left)
  end

  defp perform(pebbles) do
    cond do
      pebbles <= 0 -> {:empty, pebbles}
      pebbles == 1 -> {:error, pebbles}
      true -> {:ok, :rand.uniform(3)}
    end    
  end
end

defmodule Pebbles.Client do
  def get do
    send :pebbles_server, {:get, self()}
    receive do
      response -> response
    end
  end
end

defmodule Pebbles.Game do
  def start do
    Pebbles.Server.start
    process_move(Pebbles.Client, Pebbles.Client)
  end

  defp process_move(first_player, second_player) do
    handle_response(first_player, 'Mark')
    :timer.sleep 1000
    handle_response(second_player, 'Susan')
    :timer.sleep 1000
    process_move(first_player, second_player)
  end

  defp handle_response(player, label) do
    case player.get do
      {:ok, pebbles_count} -> IO.puts("#{label} pulled #{pebbles_count} pebbles")
      {:empty, _} ->
        IO.puts("Draw! Pebbles empty")
        System.halt
      {:error, _} ->
        IO.puts("#{label} loose")
        System.halt
    end
  end
end

Pebbles.Game.start
