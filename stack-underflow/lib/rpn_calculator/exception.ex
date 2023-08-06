defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @default_message "stack underflow occurred"

    defexception message: @default_message

    @impl true
    def exception(context) do
      case context do
        [] ->
          %StackUnderflowError{}
        _ ->
          %StackUnderflowError{message: @default_message <> ", context: #{context}"}
      end
    end
  end

  def divide(stack) do
    case stack do
      [] -> raise StackUnderflowError, "when dividing"
      [_] -> raise StackUnderflowError, "when dividing"
      [a, _] when a == 0 -> raise DivisionByZeroError
      [a, b] -> b / a
    end
  end
end
