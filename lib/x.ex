defmodule X do
  alias Eray.Vector
  alias Eray.Graphics
  alias Eray.Ray
  alias Eray.Scene
  alias Eray.Quaternion
  alias Eray.Object

  def pixel_vector_hit(triangles, {pixel, vector}) do
    ray_dir = Vector.sub(Vector.new(0, 0, 0), vector)
    ray = Ray.new(vector, ray_dir)

    triangle = Scene.get_ray_hit(triangles, ray)

    if triangle == nil do
      nil
    else
      {pixel, triangle.color}
    end
  end

  def hits_stream(pixels, triangles) do
    Stream.map(pixels, fn p -> pixel_vector_hit(triangles, p) end)
    |> Stream.filter(fn e -> e != nil end)
  end

  defp draw_pixel({{x, y}, color}) do
    r = round(color.r * 255)
    g = round(color.g * 255)
    b = round(color.b * 255)
    Graphics.set_pixel(r, g, b, x, y)
  end

  def draw_pixels(pixels) do
    IO.puts("drawing...")
    Graphics.clear_pixels()
    Enum.each(pixels, &draw_pixel/1)
    IO.puts("done")
  end

  def draw_rotated(screen, object, angle) do
    rotor = Quaternion.rotor(angle, Vector.new(0.0, 1.0, 0.0))

    triangles = Object.set_rotation(object, rotor) |> Object.get_triangles()

    Screen.get_pixel_vectors(screen) |> hits_stream(triangles) |> draw_pixels()

    Graphics.update_window()
  end

  def t do
    screen = Screen.new(640, 480, 240)
    Graphics.init(screen.width, screen.height)

    object = Scene.load_pyramid()

    steps = 64

    Enum.map(0..steps, fn a -> a * (2.0 * :math.pi() / steps) end)
    |> Enum.map(fn ang -> draw_rotated(screen, object, ang) end)
  end

  def q do
    q0 = Quaternion.new(0.1, 1, 0, 0)
    q1 = Quaternion.new(1, 0, 0, 1)
    IO.puts("q0 #{inspect(q0)} q1 #{inspect(q1)}")

    r = Quaternion.product(q0, q1)
    IO.puts("r #{inspect(r)}")
  end

  # test rotation
  defp rotate(angle, axis, vertex) do
    rotor = Quaternion.rotor(angle, axis)
    IO.puts("angle #{angle} rotor #{inspect(rotor)}")
    Quaternion.product(rotor, vertex) |> Quaternion.product(Quaternion.inverse(rotor))
  end

  def r do
    angle = :math.pi() / 2
    axis = Vector.new(0.0, 1.0, 0.0)
    vertex = Quaternion.new(0.0, 0.0, 1.0, 0.0)

    rotate(angle, axis, vertex)

    Enum.map(0..10, fn a -> a * (:math.pi() / 10) end)
    |> Enum.map(fn ang -> rotate(ang, axis, vertex) end)
  end
end
