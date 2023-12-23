defmodule Eray.Scene do
  alias Eray.Scene
  alias Eray.Space
  alias Eray.Vector
  alias Eray.Triangle

  defstruct triangles: []

  def load do
    t = [
      Triangle.new(
        Vector.new(0, 20, 100),
        Vector.new(10, -20, 100),
        Vector.new(-10, -20, 100),
        200,
        0,
        0
      ),
      Triangle.new(
        Vector.new(0 + 5, 20, 110),
        Vector.new(10 + 5, -20, 110),
        Vector.new(-10 + 5, -20, 110),
        0,
        180,
        0
      )
    ]

    %Scene{triangles: t}
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

  def get_ray_hit(scene, ray) do
    find_hits(scene.triangles, ray, :infinity, nil)
  end
end
