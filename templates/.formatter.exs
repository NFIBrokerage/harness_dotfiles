locals_without_parens = <%= Kernel.inspect(@formatter_locals_without_parens) %>

[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  import_deps: <%= Kernel.inspect(@formatter_deps) %>,
  locals_without_parens: locals_without_parens,
  export: [locals_without_parens: locals_without_parens],
  line_length: 80
]
