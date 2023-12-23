defmodule Eray.Color do
  alias Eray.Color
  defstruct r: 0.0, g: 0.0, b: 0.0

  def new(r, g, b) do
    %Color{r: r, g: g, b: b}
  end
end
