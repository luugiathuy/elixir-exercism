# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn -> {1, %{}} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, plot_map} -> Map.values(plot_map) end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {next_id, plot_map} ->
      plot = %Plot{plot_id: next_id, registered_to: register_to}
      {plot, {next_id + 1, Map.put(plot_map, next_id, plot)}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {next_id, plot_map} -> {next_id, Map.delete(plot_map, plot_id)} end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {_, plot_map} -> Map.get(plot_map, plot_id, {:not_found, "plot is unregistered"}) end)
  end
end
