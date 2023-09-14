defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram?(base, &1))
  end

  defp anagram?(a, b) do
    a_downcase = String.downcase(a)
    b_downcase = String.downcase(b)
    String.bag_distance(a_downcase, b_downcase) == 1.0 && a_downcase != b_downcase
  end
end
