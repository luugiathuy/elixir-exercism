defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    do_calc(0, input)
  end

  defp do_calc(acc, 1), do: acc

  defp do_calc(acc, input) do
    if rem(input, 2) == 0 do
      do_calc(acc + 1, div(input, 2))
    else
      do_calc(acc + 1, input * 3 + 1)
    end
  end
end
