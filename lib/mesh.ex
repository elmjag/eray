defmodule Eray.Mesh do
  alias Eray.Quaternion
  alias Eray.Triangle
  alias Eray.Vector
  alias Eray.Color
  alias Eray.Mesh

  defstruct vertices: [], colors: [], faces: []

  #
  # vertices - all vertices referenced in this mesh
  # colors   - list of rgb values for each color
  # faces    - faces defined by indices in vertices and colors lists
  #

  #
  # face is specified by indices to the vertices and color list as follows:
  #
  # {vertex0_index, vertex1_index, vertex2_index, color_index}
  #
  @type face() :: {integer, integer, integer, integer}

  @spec new(list(%Vector{}), list(%Color{}), list(face)) :: %Mesh{}
  def new(vertices, colors, faces) do
    %Mesh{vertices: vertices, colors: colors, faces: faces}
  end

  defp translate_vertices([], _) do
    []
  end

  defp translate_vertices([vert | rest], t) do
    [Vector.add(vert, t) | translate_vertices(rest, t)]
  end

  @spec translate(%Mesh{}, %Vector{}) :: %Mesh{}
  def translate(mesh, translation) do
    translated_vertices = translate_vertices(mesh.vertices, translation)
    new(translated_vertices, mesh.colors, mesh.faces)
  end

  @spec q2v(%Quaternion{}) :: %Vector{}
  defp q2v(q) do
    Vector.new(q.x, q.y, q.z)
  end

  @spec v2q(%Vector{}) :: %Quaternion{}
  defp v2q(v) do
    Quaternion.new(0.0, v.x, v.y, v.z)
  end

  defp rotate_vertices([], _, _) do
    []
  end

  defp rotate_vertices([vert | rest], rotor, inv_rotor) do
    qrotated = Quaternion.product(rotor, v2q(vert)) |> Quaternion.product(inv_rotor)
    [q2v(qrotated) | rotate_vertices(rest, rotor, inv_rotor)]
  end

  @spec rotate(%Mesh{}, %Quaternion{}) :: %Mesh{}
  def rotate(mesh, rotor) do
    inv_rotor = Quaternion.inverse(rotor)
    rotated_vertices = rotate_vertices(mesh.vertices, rotor, inv_rotor)

    new(rotated_vertices, mesh.colors, mesh.faces)
  end

  defp by_index(elems) do
    Map.new(for {i, v} <- Stream.with_index(elems), do: {v, i})
  end

  defp faces_to_triangles([], _, _) do
    []
  end

  defp faces_to_triangles([face | rest], vertices, colors) do
    {v0, v1, v2, color} = face
    triangle = Triangle.new(vertices[v0], vertices[v1], vertices[v2], colors[color])
    [triangle | faces_to_triangles(rest, vertices, colors)]
  end

  @spec get_triangles(%Mesh{}) :: list(%Triangle{})
  def get_triangles(mesh) do
    verts = by_index(mesh.vertices)
    colors = by_index(mesh.colors)

    faces_to_triangles(mesh.faces, verts, colors)
  end
end
