defmodule Eray.Triangle do
  alias Eray.Vector
  alias Eray.Triangle
  alias Eray.Color

  defstruct vert0: nil, vert1: nil, vert2: nil, color: nil, edge1: nil, edge2: nil, normal: nil

  @spec new(%Vector{}, %Vector{}, %Vector{}, %Color{}) :: %Triangle{}
  def new(vert0, vert1, vert2, color) do
    edge1 = Vector.sub(vert1, vert0)
    edge2 = Vector.sub(vert2, vert0)
    normal = Vector.normalize(Vector.cross(edge1, edge2))

    %Triangle{
      vert0: vert0,
      vert1: vert1,
      vert2: vert2,
      color: color,
      edge1: edge1,
      edge2: edge2,
      normal: normal
    }
  end

  @spec set_color(%Triangle{}, %Color{}) :: %Triangle{}
  def set_color(triangle, new_color) do
    %Triangle{triangle | color: new_color}
  end
end
