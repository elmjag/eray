defmodule Screen do
  alias Eray.Vector

  defstruct width: nil, height: nil, depth: nil

  def new(width, height, depth) do
    %Screen{width: width, height: height, depth: depth}
  end

  defp get_vector_xy_offsets(screen) do
    xoffset =
      if rem(screen.width, 2) == 0 do
        # width is even number
        -(screen.width / 2) + 0.5
      else
        # width is odd number
        -((screen.width - 1) / 2)
      end

    yoffset =
      if rem(screen.height, 2) == 0 do
        # height is even number
        screen.height / 2 - 0.5
      else
        # height is odd number
        (screen.height - 1) / 2
      end

    {xoffset, yoffset}
  end

  def pixel_vector(x, y, xoffset, yoffset, depth) do
    vx = x + xoffset
    vy = -y + yoffset
    vect = Vector.new(vx, vy, -depth)

    {{x, y}, vect}
  end

  def get_pixel_vectors(screen) do
    {xoffset, yoffset} = get_vector_xy_offsets(screen)

    Stream.flat_map(
      0..(screen.height - 1),
      fn y ->
        Stream.map(
          0..(screen.width - 1),
          fn x -> pixel_vector(x, y, xoffset, yoffset, screen.depth) end
        )
      end
    )
  end
end
