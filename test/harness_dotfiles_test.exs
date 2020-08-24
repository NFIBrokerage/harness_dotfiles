defmodule HarnessDotfilesTest do
  use ExUnit.Case, async: true

  describe "given an empty opts kwlist" do
    setup do
      [opts: []]
    end

    test "casting the configuration produces the default struct", c do
      assert HarnessDotfiles.cast(c.opts) === %HarnessDotfiles{}
    end
  end

  test "_all_ generated files are linked" do
    generated_files = File.ls!("templates") |> MapSet.new()
    links = HarnessDotfiles.links(%HarnessDotfiles{}) |> MapSet.new()

    assert MapSet.equal?(generated_files, links)
  end

  test "the credo config can be read as valid elixir" do
    assert {%{}, []} = ".credo.exs" |> fixture() |> Code.eval_file()
  end

  defp fixture(filename) do
    Path.join("fixture", filename)
  end
end
