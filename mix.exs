defmodule Eray.MixProject do
  use Mix.Project

  def project() do
    [
      app: :eray,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      make_cwd: "gfxnif",
      make_clean: ["clean"],
      compilers: [:elixir_make] ++ Mix.compilers()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:elixir_make, "~> 0.7", runtime: false}
    ]
  end
end
