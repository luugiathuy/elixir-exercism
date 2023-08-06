defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 ->
        Map.put(results, input, :timeout)
    end

  end

  def reliability_check(calculator, inputs) do
    save_trap_exit_flag = Process.flag(:trap_exit, true)
    result = inputs
    |> Enum.map(& start_reliability_check(calculator, &1))
    |> Enum.reduce(%{}, fn (check, results) ->
      await_reliability_check_result(check, results)
    end)
    Process.flag(:trap_exit, save_trap_exit_flag)
    result
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input ->
      Task.async(fn -> calculator.(input) end)
    end)
    |> Enum.map(& Task.await(&1, 100))
  end
end
