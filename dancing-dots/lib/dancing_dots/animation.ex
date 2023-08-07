defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error,  error}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{} = dot, frame_number, _opts) do
    cond do
      rem(frame_number, 4) == 0 -> %{ dot | opacity: dot.opacity / 2}
      true -> dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    case Keyword.get(opts, :velocity) do
      x when is_number(x) -> {:ok, opts}
      value -> {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(value)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{} = dot, frame_number, opts) do
    {:ok, [velocity: velocity]} = init(opts)
    %{dot | radius: dot.radius + (frame_number - 1) * velocity}
  end
end
