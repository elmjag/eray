defmodule X do
  alias Eray.Vector
  alias Eray.Graphics
  alias Eray.Triangle
  alias Eray.Ray
  alias Eray.Space

  def pixel_vector_hit(triangle, {pixel, vector}) do
    ray_dir = Vector.sub(Vector.new(0, 0, 0), vector)
    ray = Ray.new(vector, ray_dir)

    {pixel, Space.intersect(ray, triangle)}
  end

  def hits_stream(pixels, triangle) do
    Stream.map(pixels, fn p -> pixel_vector_hit(triangle, p) end)
    |> Stream.filter(fn {_pixel, hit} -> hit end)
    |> Stream.map(fn {pixel, _} -> pixel end)
  end

  def dump(pixel_hits) do
    Enum.each(pixel_hits, fn p -> IO.puts(inspect(p)) end)
  end

  def draw_pixels(screen, pixels) do
    Graphics.init(screen.width, screen.height)

    Enum.each(pixels, fn {x, y} -> Graphics.set_pixel(200, 0, 0, x, y) end)

    Graphics.update_window()
  end

  def t do
    screen = Screen.new(640, 480, 64)
    triangle = Triangle.new(Vector.new(0, 20, 8), Vector.new(10, -20, 8), Vector.new(-10, -20, 8))

    pixels = Screen.get_pixel_vectors(screen) |> hits_stream(triangle)
    draw_pixels(screen, pixels)
  end
end
