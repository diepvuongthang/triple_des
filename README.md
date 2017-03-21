# TripleDes

  ```elixir
  mode: :des3_ecb, :des3_cbc, des_ede3
  key: iodata, must be a multiple of 64 bits (8 bytes).
  ivec: an arbitrary initializing vector, must be a multiple of 64 bits (8 bytes).
  data: iodata, must be a multiple of 64 bits (8 bytes).
  ```

  ## Examples
  ```elixir
  TripleDes.encrypt(mode, key, data)
  TripleDes.decrypt(mode, key, data)
  TripleDes.encrypt(mode, key, ivec, data)
  TripleDes.decrypt(mode, key, ivec, data)
  ```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `triple_des` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:triple_des, "~> 1.0.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/triple_des](https://hexdocs.pm/triple_des).

