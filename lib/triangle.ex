defmodule Eray.Triangle do
  alias Eray.Triangle
  defstruct vert0: nil, vert1: nil, vert2: nil

  def new(vert0, vert1, vert2) do
    %Triangle{vert0: vert0, vert1: vert1, vert2: vert2}
  end
end
