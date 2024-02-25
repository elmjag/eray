defmodule Eray.Scene do
  alias Eray.Scene
  alias Eray.Object
  alias Eray.Quaternion
  alias Eray.Lighting
  alias Eray.Color
  alias Eray.Mesh
  alias Eray.Space
  alias Eray.Vector
  alias Eray.Triangle

  defstruct object: nil, lighting: nil

  @spec load_square() :: %Scene{}
  def load_square do
    vertices = [
      Vector.new(-20.0, 20.0, 0.0),
      Vector.new(20.0, 20.0, 0.0),
      Vector.new(20.0, -20.0, 0.0),
      Vector.new(-20.0, -20.0, 0.0)
    ]

    colors = [
      Color.new(1.0, 0.0, 0.0),
      Color.new(0.0, 1.0, 0.0)
    ]

    faces = [
      {3, 0, 2, 0},
      {2, 0, 1, 1}
    ]

    mesh = Mesh.new(vertices, colors, faces)
    rotation = Quaternion.rotor(0.0, Vector.new(0.0, 1.0, 0.0))
    translation = Vector.new(0.0, 0.0, 80.0)
    object = Object.new(rotation, translation, mesh)
    lighting = Lighting.new(0.0, Vector.new(0.0, 0.0, 1.0))

    %Scene{object: object, lighting: lighting}
  end

  @spec load_pyramid() :: %Scene{}
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
    object = Object.new(rotation, translation, mesh)
    lighting = Lighting.new(0.0, Vector.new(0.0, 0.0, 1.0))

    %Scene{object: object, lighting: lighting}
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

  @doc "triangle's color taking into account lighting"
  def illuminated_color(scene, triangle) do
    dot_prod = Vector.dot(scene.lighting.directional, triangle.normal)

    new_color =
      if dot_prod >= 0.0 do
        # no directional light
        Color.new(0.0, 0.0, 0.0)
      else
        f = dot_prod * -1.0
        tc = triangle.color
        Color.new(tc.r * f, tc.g * f, tc.b * f)
      end

    Triangle.set_color(triangle, new_color)
  end

  def get_triangles(scene) do
    Enum.map(Object.get_triangles(scene.object), fn tri -> illuminated_color(scene, tri) end)
  end
end
