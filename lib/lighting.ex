defmodule Eray.Lighting do
  @moduledoc """
  Specifies lighting in a scene.
  """
  alias Eray.Lighting
  alias Eray.Vector

  defstruct ambient: 0.0, directional: nil

  @spec new(float(), %Vector{}) :: %Lighting{}
  def new(ambient, directional) do
    %Lighting{ambient: ambient, directional: Vector.normalize(directional)}
  end
end
