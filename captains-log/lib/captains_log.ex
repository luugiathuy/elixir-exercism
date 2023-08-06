defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    number = 1000..9999
    |> Range.to_list()
    |> Enum.random()
    "NCC-#{number}"
  end

  def random_stardate() do
    41000.0 + :rand.uniform() * 1000.0
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate])
    |> to_string()
  end
end
