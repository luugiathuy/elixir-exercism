defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {op, _, [{:when, _, [func_params | _]} | _]} when op == :def or op == :defp ->
        {ast, [decode_function_name(func_params) | acc]}
      {op, _, [func_params | _]} when op == :def or op == :defp ->
        {ast, [decode_function_name(func_params) | acc]}
      _ -> {ast, acc}
    end
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    acc
    |> Enum.reverse()
    |> Enum.join("")
  end

  defp decode_function_name(func_params) do
    case func_params do
      {_name, _, nil} -> ""
      {name, _, args} -> name |> to_string() |> String.slice(0, length(args))
    end
  end
end
