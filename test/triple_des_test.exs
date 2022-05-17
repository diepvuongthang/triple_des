defmodule TripleDesTest do
  use ExUnit.Case
  doctest TripleDes

  @key "A1993AB2022AC999992222AF"

  test "can encrypt and decrypt" do
    encrypted = TripleDes.encrypt("somethingwickedthiswaycomes.....", @key, :des3_ecb)

    assert "somethingwickedthiswaycomes....." == TripleDes.decrypt(encrypted, @key, :des3_ecb)
  end
end
