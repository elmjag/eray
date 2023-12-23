defmodule Eray.Ray do
  alias Eray.Ray
  alias Eray.Vector

  defstruct orig: nil, dir: nil

  def new(orig, dir) do
    %Ray{orig: orig, dir: Vector.normalize(dir)}
  end
end
