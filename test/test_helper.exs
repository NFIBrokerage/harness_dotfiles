{output, _exit_status = 0} =
  System.cmd("bash", ["-c", "mix do harness.get, harness"], cd: "fixture/")

IO.puts(output)
ExUnit.start()
