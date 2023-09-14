defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when is_integer(output_base) and output_base < 2 do
    {:error, "output base must be >= 2"}
  end

  def convert(_, input_base, _) when is_integer(input_base) and input_base < 2 do
    {:error, "input base must be >= 2"}
  end

  def convert(digits, input_base, output_base)
      when is_integer(input_base) and is_integer(output_base) do
    if Enum.all?(digits, &valid_digit?(&1, input_base)) do
      {:ok, do_convert(digits, input_base, output_base)}
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp valid_digit?(digit, base), do: 0 <= digit && digit < base

  defp do_convert(digits, input_base, output_base) do
    cond do
      input_base == output_base ->
        digits

      true ->
        digits
        |> convert_to_10(input_base)
        |> convert_from_10(output_base)
    end
  end

  @spec convert_to_10(list(), pos_integer()) :: integer()
  defp convert_to_10(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.reduce({1, 0}, fn digit, {base_value, acc} ->
      {base_value * input_base, acc + digit * base_value}
    end)
    |> elem(1)
  end

  @spec convert_from_10(integer(), pos_integer()) :: list()
  defp convert_from_10(number, output_base) do
    convert_from_10_acc([], number, output_base)
  end

  defp convert_from_10_acc(result, number, output_base) do
    case number do
      x when x < output_base ->
        [x | result]

      _ ->
        convert_from_10_acc(
          [rem(number, output_base) | result],
          div(number, output_base),
          output_base
        )
    end
  end
end
