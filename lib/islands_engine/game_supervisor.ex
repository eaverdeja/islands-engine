defmodule IslandsEngine.GameSupervisor do
  use DynamicSupervisor

  alias IslandsEngine.Game

  def start_link(_options),
    do: DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok),
    do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_game(name),
    do: DynamicSupervisor.start_child(__MODULE__, {Game, name})

  def stop_game(name) do
    :ets.delete(:game_state, name)
    DynamicSupervisor.terminate_child(__MODULE__, pid_from_name(name))
  end

  def children,
    do: DynamicSupervisor.which_children(__MODULE__)

  def count,
    do: DynamicSupervisor.count_children(__MODULE__)

  defp pid_from_name(name) do
    name
    |> Game.via_tuple()
    |> GenServer.whereis()
  end
end
