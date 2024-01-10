defmodule TestOutbox.MixProject do
  use Mix.Project

  def project do
    [
      app: :test_outbox,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TestOutbox.Runtime, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 5.0"},
      {:plug, "~> 1.14.2"},
      {:cowboy, "~> 2.10.0"},
      {:plug_cowboy, "~> 2.6.1"},
      # Persistence
      {:ecto, "~> 3.10.3"},
      {:ecto_sql, "~> 3.10.2"},
      {:myxql, "~> 0.6.3"},
      {:postgrex, ">= 0.0.0"},
      # Outbox
      {:outbox, path: "../outbox"},
      # Code analysis
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end
end
