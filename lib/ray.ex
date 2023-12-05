defmodule Eray.Ray do
  alias Eray.Ray
  defstruct orig: nil, dir: nil

  def new(orig, dir) do
    %Ray{orig: orig, dir: dir}
  end
end
