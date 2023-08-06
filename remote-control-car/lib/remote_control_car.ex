defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %__MODULE__{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    cond do
      remote_car.battery_percentage <= 0 -> "Battery empty"
      true -> "Battery at #{remote_car.battery_percentage}%"
    end
  end

  def drive(%RemoteControlCar{} = remote_car) do
    cond do
      remote_car.battery_percentage <= 0 -> remote_car
      true -> %{remote_car | battery_percentage: remote_car.battery_percentage - 1, distance_driven_in_meters: remote_car.distance_driven_in_meters + 20}
    end
  end
end
