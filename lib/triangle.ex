defmodule Eray.Triangle do
  alias Eray.Triangle
  alias Eray.Color

  defstruct vert0: nil, vert1: nil, vert2: nil, color: nil

  def new(vert0, vert1, vert2, r, g, b) do
    %Triangle{vert0: vert0, vert1: vert1, vert2: vert2, color: Color.new(r, g, b)}
  end
end
