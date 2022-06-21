defmodule TripleDesTest do
  use ExUnit.Case
  doctest TripleDes

  @key "A1993AB2022AC999992222AF"
  @key2 "B2003AB2022AC999992222AF"

  test "can encrypt and decrypt without iv" do
    encrypted = TripleDes.encrypt("somethingwickedthiswaycomes.....", @key, :des3_ecb)

    assert "somethingwickedthiswaycomes....." == TripleDes.decrypt(encrypted, @key, :des3_ecb)
  end

  test "can encrypt but fail decription due to wrong key" do
    encrypted = TripleDes.encrypt("somethingwickedthiswaycomes.....", @key, :des3_ecb)

    assert TripleDes.decrypt(encrypted, @key2, :des3_ecb) != "somethingwickedthiswaycomes....."
  end
end
