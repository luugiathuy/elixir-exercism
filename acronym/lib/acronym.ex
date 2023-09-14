defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.trim()
    |> String.split([" ", "-"])
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(fn word ->
      word
      |> String.replace(~r/[^a-zA-Z\d:]/, "")
      |> String.first()
      |> String.upcase()
    end)
    |> Enum.join()
  end
end
