defmodule SpaceTest do
  use ExUnit.Case

  # gives us <~> operator
  import Math

  alias Eray.Ray
  alias Eray.Triangle
  alias Eray.Vector
  alias Eray.Space

  setup_all do
    # triangle
    v0 = Vector.new(0.0, 0.0, 5.0)
    v1 = Vector.new(0.0, 1.0, 5.0)
    v2 = Vector.new(1.0, 0.0, 5.0)
    triangle = Triangle.new(v0, v1, v2, nil)

    {:ok, triangle: triangle}
  end

  test "hit", state do
    # ray
    ray_orig = Vector.new(0.5, 0.5, -10.0)
    ray_dir = Vector.new(0.0, 0.0, 1.0)
    ray = Ray.new(ray_orig, ray_dir)

    t = Space.intersects(ray, state.triangle)
    assert t <~> 15.0
  end

  test "miss", state do
    # ray
    ray_orig = Vector.new(2.0, 0.5, -10.0)
    ray_dir = Vector.new(0.0, 0.0, 1.0)
    ray = Ray.new(ray_orig, ray_dir)

    t = Space.intersects(ray, state.triangle)
    assert t == nil
  end
end
