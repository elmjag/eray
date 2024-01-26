defmodule Eray.Object do
  alias Eray.Mesh
  alias Eray.Vector
  alias Eray.Quaternion
  alias Eray.Object
  alias Eray.Triangle

  defstruct rotation: nil, translation: nil, mesh: nil

  @spec new(%Quaternion{}, %Vector{}, %Mesh{}) :: %Object{}
  def new(rotation, translation, mesh) do
    %Object{rotation: rotation, translation: translation, mesh: mesh}
  end

  @spec set_rotation(%Object{}, %Quaternion{}) :: %Object{}
  def set_rotation(object, rotation) do
    %Object{object | rotation: rotation}
  end

  @spec get_triangles(%Object{}) :: list(%Triangle{})
  def get_triangles(object) do
    Mesh.rotate(object.mesh, object.rotation)
    |> Mesh.translate(object.translation)
    |> Mesh.get_triangles()
  end
end
