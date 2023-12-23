defmodule X do
  alias Eray.Vector
  alias Eray.Graphics
  alias Eray.Ray
  alias Eray.Scene

  def pixel_vector_hit(scene, {pixel, vector}) do
    ray_dir = Vector.sub(Vector.new(0, 0, 0), vector)
    ray = Ray.new(vector, ray_dir)

    triangle = Scene.get_ray_hit(scene, ray)

    if triangle == nil do
      nil
    else
      {pixel, triangle.color}
    end
  end

  def hits_stream(pixels, scene) do
    Stream.map(pixels, fn p -> pixel_vector_hit(scene, p) end)
    |> Stream.filter(fn e -> e != nil end)
  end

  defp draw_pixel({{x, y}, color}) do
    Graphics.set_pixel(color.r, color.g, color.b, x, y)
  end

  def draw_pixels(pixels, screen) do
    Graphics.init(screen.width, screen.height)

    Enum.each(pixels, &draw_pixel/1)

    Graphics.update_window()
  end

  def t do
    screen = Screen.new(640, 480, 240)
    scene = Scene.load()

    Screen.get_pixel_vectors(screen) |> hits_stream(scene) |> draw_pixels(screen)
  end
end
