defmodule Eray.Quaternion do
  alias Eray.Quaternion

  defstruct w: 0.0, x: 0.0, y: 0.0, z: 0.0

  def new(w, x, y, z) do
    %Quaternion{w: w, x: x, y: y, z: z}
  end

  def product(l, r) do
    w = l.w * r.w - l.x * r.x - l.y * r.y - l.z * r.z
    x = l.w * r.x + l.x * r.w + l.y * r.z - l.z * r.y
    y = l.w * r.y - l.x * r.z + l.y * r.w + l.z * r.x
    z = l.w * r.z + l.x * r.y - l.y * r.x + l.z * r.w

    Quaternion.new(w, x, y, z)
  end

  def inverse(quat) do
    new(quat.w, -quat.x, -quat.y, -quat.z)
  end

  def rotor(angle, axis) do
    half_angle = angle / 2
    sin_val = :math.sin(half_angle)

    w = :math.cos(half_angle)
    x = sin_val * axis.x
    y = sin_val * axis.y
    z = sin_val * axis.z

    new(w, x, y, z)
  end
end
