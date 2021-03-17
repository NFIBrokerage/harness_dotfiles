defmodule HarnessDotfilesTest do
  use ExUnit.Case, async: true

  describe "given an empty opts kwlist" do
    setup do
      [opts: []]
    end

    test "casting the configuration produces a struct", c do
      assert %HarnessDotfiles{} = HarnessDotfiles.cast(c.opts)
    end
  end

  test "_all_ generated files are linked" do
    generated_files = File.ls!("templates") |> MapSet.new()

    links =
      %HarnessDotfiles{}
      |> HarnessDotfiles.links()
      |> Enum.map(fn {file, _link_type} -> file end)
      |> MapSet.new()

    assert MapSet.equal?(generated_files, links)
  end

  test "the elixir configs can be read as valid elixir" do
    assert {%{}, []} = ".credo.exs" |> fixture() |> Code.eval_file()

    assert {[{_k, _v} | _], _bindings} =
             ".formatter.exs" |> fixture() |> Code.eval_file()
  end

  test "the json config can be read as valid json" do
    assert {:ok, _json} =
             "coveralls.json" |> fixture() |> File.read!() |> Jason.decode()
  end

  defp fixture(filename) do
    Path.join("fixture", filename)
  end
end
