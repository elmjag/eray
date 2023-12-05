defmodule Eray.Vector do
  alias Eray.Vector
  defstruct x: 0.0, y: 0.0, z: 0.0

  def new(x, y, z) do
    %Vector{x: x, y: y, z: z}
  end

  def sub(a, b) do
    %Vector{
      x: a.x - b.x,
      y: a.y - b.y,
      z: a.z - b.z
    }
  end

  def cross(a, b) do
    %Vector{
      x: a.y * b.z - a.z * b.y,
      y: a.z * b.x - a.x * b.z,
      z: a.x * b.y - a.y * b.x
    }
  end

  def dot(a, b) do
    a.x * b.x + a.y * b.y + a.z * b.z
  end
end
