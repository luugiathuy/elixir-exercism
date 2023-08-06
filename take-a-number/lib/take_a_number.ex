defmodule TakeANumber do
  def start() do
    spawn(fn -> take_a_number(0) end)
  end

  defp take_a_number(state) do
    receive do
      {:report_state, pid} ->
        send(pid, state)
        take_a_number(state)
      {:take_a_number, pid} ->
        send(pid, state + 1)
        take_a_number(state + 1)
      :stop -> nil
      _ -> take_a_number(state)
    end
  end
end
