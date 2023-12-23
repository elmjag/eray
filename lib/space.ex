defmodule Eray.Space do
  alias Eray.Vector

  def intersects(ray, triangle) do
    #
    # Möller–Trumbore intersection algorithm
    #
    edge1 = Vector.sub(triangle.vert1, triangle.vert0)
    edge2 = Vector.sub(triangle.vert2, triangle.vert0)
    pvec = Vector.cross(ray.dir, edge2)
    det = Vector.dot(edge1, pvec)

    if det < 0 do
      # backface culling
      nil
    else
      tvec = Vector.sub(ray.orig, triangle.vert0)
      u = Vector.dot(tvec, pvec)

      if u < 0 or u > det do
        nil
      else
        qvec = Vector.cross(tvec, edge1)
        v = Vector.dot(ray.dir, qvec)

        if v < 0 or u + v > det do
          nil
        else
          t = Vector.dot(edge2, qvec) / det
          t
        end
      end
    end
  end
end
