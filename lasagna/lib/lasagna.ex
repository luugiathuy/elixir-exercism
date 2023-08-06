defmodule Lasagna do
  def expected_minutes_in_oven, do: 40

  def remaining_minutes_in_oven(minutes_in_oven) do
    if minutes_in_oven > expected_minutes_in_oven() do
      0
    else
      expected_minutes_in_oven() - minutes_in_oven
    end
  end

  def preparation_time_in_minutes(layer_count), do: 2 * layer_count

  def total_time_in_minutes(layer_count, minutes_in_oven), do: preparation_time_in_minutes(layer_count) + minutes_in_oven

  def alarm, do: "Ding!"
end
