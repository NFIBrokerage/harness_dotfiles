import Config

config :harness,
  manifest_version: "2.0.0",
  generators: [HarnessDotfiles],
  deps: [
    {:harness_dotfiles, path: "../"}
  ]

config :harness_dotfiles,
  asdf_elixir_version: "1.10.3-otp-21"
