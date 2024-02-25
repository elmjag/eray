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
      {:elixir_make, "~> 0.7", runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:math, "~> 0.6.0"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end
end
