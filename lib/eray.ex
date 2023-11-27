defmodule Eray do
  alias Eray.Graphics

  @moduledoc """
  Documentation for `Eray`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Eray.hello()
      :world

  """
  def hello do
    :world
  end

  def test_draw() do
    Graphics.init(200, 200)
    Graphics.set_pixel(0, 0, 200, 100, 100)
    Graphics.set_pixel(0, 0, 200, 101, 100)
    Graphics.set_pixel(0, 0, 200, 102, 100)
    Graphics.update_window()
  end
end
