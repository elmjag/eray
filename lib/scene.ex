defmodule Eray.Scene do
  alias Eray.Object
  alias Eray.Quaternion
  alias Eray.Color
  alias Eray.Mesh
  alias Eray.Space
  alias Eray.Vector

  @spec load_pyramid() :: %Object{}
  def load_pyramid do
    vertices = [
      Vector.new(0.0, 20.0, 0.0),
      Vector.new(10.0, -20.0, -10.0),
      Vector.new(-10.0, -20.0, -10.0),
      Vector.new(-10.0, -20.0, 10.0),
      Vector.new(10.0, -20.0, 10.0)
    ]

    colors = [
      Color.new(1.0, 0.0, 0.0),
      Color.new(0.0, 1.0, 0.0),
      Color.new(0.0, 0.0, 1.0),
      Color.new(1.0, 1.0, 0.0)
    ]

    faces = [
      {0, 1, 2, 0},
      {0, 2, 3, 1},
      {0, 3, 4, 2},
      {0, 4, 1, 3}
    ]

    mesh = Mesh.new(vertices, colors, faces)
    rotation = Quaternion.rotor(0.0, Vector.new(0.0, 1.0, 0.0))
    translation = Vector.new(0.0, 0.0, 80.0)

    Object.new(rotation, translation, mesh)
  end

  defp find_hits([], _, _, triangle) do
    triangle
  end

  defp find_hits([new_triangle | rest], ray, distance, triangle) do
    new_distance = Space.intersects(ray, new_triangle)

    cond do
      new_distance == nil ->
        # no hit, use previous hit
        find_hits(rest, ray, distance, triangle)

      new_distance < distance ->
        # new hit is closer to origin
        find_hits(rest, ray, new_distance, new_triangle)

      true ->
        # old hit is closer to origin
        find_hits(rest, ray, distance, triangle)
    end
  end

  def get_ray_hit(triangles, ray) do
    find_hits(triangles, ray, :infinity, nil)
  end
end
