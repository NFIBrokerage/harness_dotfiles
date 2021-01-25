defmodule HarnessDotfiles do
  @schema [
    coveralls_skip_files: [
      doc: """
      A list of file regex patterns to ignore for coveralls coverage checking.
      """,
      type: {:list, :string},
      default: ["^test", "^deps", "^.harness"]
    ],
    coveralls_minimum_coverage: [
      doc: """
      The minimum percentage of coverage to require for a successful coveralls
      coverage report.
      """,
      type: {:custom, __MODULE__, :parse_number, []},
      default: 100
    ],
    explicit_credo_checks: [
      doc: """
      A list of explicit checks to pass to the credo `:checks` configuration.
      Checks in this list will merge on top of the defaults provided in the
      `.credo.exs` template provided by this harness package. To disable a
      check, add an element to the list: `{CheckName, false}`.
      """,
      type: {:list, {:custom, __MODULE__, :parse_tuple, []}},
      default: []
    ],
    excluded_paths_for_modulename_matches_filename: [
      doc: """
      A list of elixir Regexs used to ignore files and directories from the
      Convene ModulenameMatchesFilename check. Useful for ignoring directories
      containing modules with Phoenix naming conventions.
      """,
      type: {:list, {:custom, __MODULE__, :parse_regex, []}},
      default: []
    ],
    asdf_elixir_version: [
      doc: """
      The version of elixir to use, as passed to `asdf`.
      """,
      type: :string,
      default: "1.11.2-otp-23"
    ],
    asdf_erlang_version: [
      doc: """
      The version of erlang to use, as passed to `asdf`.
      """,
      type: :string,
      default: "23.2"
    ],
    asdf_other_versions: [
      doc: """
      Other versions to include in the local `.tool-versions` file used by
      `asdf`. E.g. `["nodejs 12.13.1"]` will add Node to the local `asdf`
      requirements.
      """,
      type: {:list, :string},
      default: []
    ],
    formatter_deps: [
      doc: """
      The list of dependencies from which to import formatter config. Some
      dependencies like `:projection` or `:phoenix` export formatter
      configuration, like which functions or macros should be allowed to not
      have parentheses.
      """,
      type: {:list, :atom},
      default: []
    ],
    formatter_locals_without_parens: [
      doc: """
      A keyword list of function/macro names and arities allowed to not have
      parentheses in the local project. E.g. `[foo: 2]` will allow calls to
      `foo/2` to not need parentheses, as in `foo :bar, :baz`.
      """,
      type: :keyword_list,
      default: []
    ]
  ]

  @moduledoc """
  A harness for a common collection of dotfiles

  The options are:

  #{NimbleOptions.docs(@schema)}
  """

  @behaviour Harness.Pkg

  defstruct ~w[
    coveralls_skip_files
    coveralls_minimum_coverage
    explicit_credo_checks
    excluded_paths_for_modulename_matches_filename
    asdf_elixir_version
    asdf_erlang_version
    asdf_other_versions
    formatter_deps
    formatter_locals_without_parens
  ]a

  @doc false
  @impl Harness.Pkg
  def cast(opts) do
    struct(__MODULE__, NimbleOptions.validate!(opts, @schema))
  end

  @doc false
  @impl Harness.Pkg
  def links(_config) do
    ~w[
      .credo.exs
      .formatter.exs
      .tool-versions
      coveralls.json
    ]
  end

  @doc false
  def parse_number(number) when is_number(number) do
    {:ok, number}
  end

  def parse_number(unknown) do
    {:error, "must be a number (integer or float), got: #{inspect(unknown)}"}
  end

  @doc false
  def parse_tuple(tuple) when is_tuple(tuple) do
    {:ok, tuple}
  end

  def parse_tuple(unknown) do
    {:error, "must be a tuple, got: #{inspect(unknown)}"}
  end

  @doc false
  def parse_regex(%Regex{} = regex), do: {:ok, regex}

  def parse_regex(unknown) do
    {:error, "must be a regex, got: #{inspect(unknown)}"}
  end
end
