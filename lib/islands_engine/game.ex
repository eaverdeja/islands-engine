defmodule IslandsEngine.Game do
  use GenServer

  alias IslandsEngine.{Board, Guesses, Rules}

  def start_link(name) when is_binary(name),
    do: GenServer.start_link(__MODULE__, name)

  def init(name) do
    player1 = %{name: name, board: Board.new(), guesses: Guesses.new()}
    player2 = %{name: nil, board: Board.new(), guesses: Guesses.new()}

    {:ok, %{player1: player1, player2: player2, rules: Rules.new()}}
  end
end
