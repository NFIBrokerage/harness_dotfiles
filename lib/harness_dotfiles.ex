defmodule HarnessDotfiles do
  @moduledoc """
  A harness for a common collection of dotfiles
  """

  @behaviour Harness.Pkg

  defstruct coveralls_skip_files: ["^test", "^deps", "^.harness"],
            explicit_credo_checks: [],
            excluded_paths_for_modulename_matches_filename: [],
            asdf_elixir_version: "1.10.3-otp-21",
            asdf_erlang_version: "21.0",
            asdf_other_versions: [],
            formatter_deps: [],
            formatter_locals_without_parens: []

  @impl Harness.Pkg
  def cast(opts) do
    struct(__MODULE__, opts)
  end

  @impl Harness.Pkg
  def links(_config) do
    ~w[
      .credo.exs
      .formatter.exs
      .tool-versions
      coveralls.json
    ]
  end
end
