defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    cond do
      x * x + y * y <= 1 -> 10
      x * x + y * y <= 25 -> 5
      x * x + y * y <= 100 -> 1
      true -> 0
    end
  end
end
