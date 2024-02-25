defmodule Eray.Space do
  alias Eray.Vector
  alias Eray.Ray
  alias Eray.Triangle

  @spec intersects(%Ray{}, %Triangle{}) :: float() | nil
  def intersects(ray, triangle) do
    #
    # Möller–Trumbore intersection algorithm
    #
    pvec = Vector.cross(ray.dir, triangle.edge2)
    det = Vector.dot(triangle.edge1, pvec)

    if det < 0 do
      # backface culling
      nil
    else
      tvec = Vector.sub(ray.orig, triangle.vert0)
      u = Vector.dot(tvec, pvec)

      if u < 0 or u > det do
        nil
      else
        qvec = Vector.cross(tvec, triangle.edge1)
        v = Vector.dot(ray.dir, qvec)

        if v < 0 or u + v > det do
          nil
        else
          t = Vector.dot(triangle.edge2, qvec) / det
          t
        end
      end
    end
  end
end
