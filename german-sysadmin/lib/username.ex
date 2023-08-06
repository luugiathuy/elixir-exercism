defmodule Username do
  def sanitize(username) do
    case username do
      [] -> []
      [?_ | tail] -> [?_ | sanitize(tail)]
      [?ä | tail] -> [?a | [?e | sanitize(tail)]]
      [?ö | tail] -> [?o | [?e | sanitize(tail)]]
      [?ü | tail] -> [?u | [?e | sanitize(tail)]]
      [?ß | tail] -> [?s | [?s | sanitize(tail)]]
      [head | tail] when head >= ?a and head <= ?z -> [head | sanitize(tail)]
      [_ | tail] -> sanitize(tail)
    end
  end
end
