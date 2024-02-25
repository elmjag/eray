defmodule X do
  alias Eray.Vector
  alias Eray.Graphics
  alias Eray.Ray
  alias Eray.Scene
  alias Eray.Quaternion
  alias Eray.Object

  def pixel_ray_hit(triangles, rays_origo, {pixel, vector}) do
    ray_dir = Vector.sub(vector, rays_origo)
    ray = Ray.new(vector, ray_dir)

    triangle = Scene.get_ray_hit(triangles, ray)

    if triangle == nil do
      nil
    else
      {pixel, triangle.color}
    end
  end

  def find_hits(screen, scene) do
    pixels = Enum.to_list(Screen.get_pixel_vectors(screen))
    # hard-coded rays origo at point 0, 0, 0 for now
    rays_origo = Vector.new(0.0, 0.0, 0.0)
    triangles = Scene.get_triangles(scene)

    Stream.map(pixels, fn p -> pixel_ray_hit(triangles, rays_origo, p) end)
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

  def draw_rotated(screen, scene, angle) do
    # rotate object
    rotor = Quaternion.rotor(angle, Vector.new(0.0, 1.0, 0.0))
    scene = %Scene{scene | object: Object.set_rotation(scene.object, rotor)}

    IO.puts("draw angle #{Math.rad2deg(angle)}")

    # render the scene
    find_hits(screen, scene) |> draw_pixels()

    Graphics.update_window()
  end

  def t do
    screen = Screen.new(640, 480, 240)
    Graphics.init(screen.width, screen.height)

    scene = Scene.load_pyramid()
    # scene = Scene.load_square()

    steps = 64

    Enum.map(0..steps, fn a -> a * (2 * :math.pi() / steps) end)
    |> Enum.map(fn ang -> :timer.tc(&draw_rotated/3, [screen, scene, ang]) end)
  end
end
