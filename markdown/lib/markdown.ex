defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(&process_line/1)
    |> process_styles()
    |> wrap_ul_tag()
  end

  defp process_line("#" <> rest), do: parse_header(rest, 1)
  defp process_line("* " <> rest), do: encose_with_tag(rest, "li")
  defp process_line(str), do: encose_with_tag(str, "p")

  defp parse_header(str, 7), do: encose_with_tag("#{String.duplicate("#", 7)}#{str}", "p")
  defp parse_header(" " <> rest, header_level), do: encose_with_tag(rest, "h#{header_level}")
  defp parse_header("#" <> rest, header_level), do: parse_header(rest, header_level + 1)

  defp process_styles(str) do
    str
    |> String.replace(~r/__([^_]+)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_([^_]+)_/, "<em>\\1</em>")
  end

  defp wrap_ul_tag(t),
    do: t |> String.replace(~r/(?<!<\/li>)<li>(.*)<\/li>(?!<li>)/, "<ul><li>\\1</li></ul>")

  defp encose_with_tag(str, tag), do: "<#{tag}>#{str}</#{tag}>"
end
