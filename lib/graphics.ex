defmodule Eray.Graphics do
  @on_load :load_nif

  def load_nif do
    nif = Application.app_dir(:eray, "graphics")
    :ok = :erlang.load_nif(String.to_charlist(nif), 0)
  end

  def init(_width, _height) do
    :nif_load_error
  end

  def set_pixel(_r, _g, _b, _x, _y) do
    :nif_load_error
  end

  def clear_pixels() do
    :nif_load_error
  end

  def update_window() do
    :nif_load_error
  end
end
