defmodule Eray.Triangle do
  alias Eray.Vector
  alias Eray.Triangle
  alias Eray.Color

  defstruct vert0: nil, vert1: nil, vert2: nil, color: nil

  @spec new(%Vector{}, %Vector{}, %Vector{}, %Color{}) :: %Triangle{}
  def new(vert0, vert1, vert2, color) do
    %Triangle{vert0: vert0, vert1: vert1, vert2: vert2, color: color}
  end
end
