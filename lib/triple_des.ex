defmodule TripleDes do
  @moduledoc """
  Documentation for TripleDes.
  ```elixir
  mode: :des3_ecb, :des3_cbc, :des_ede3
  key: iodata, must be a multiple of 64 bits (8 bytes).
  ivec: an arbitrary initializing vector, must be a multiple of 64 bits (8 bytes)
  data: iodata, must be a multiple of 64 bits (8 bytes).
  ```
  """

  @doc """
  ## Examples
  """
  def encrypt(data, key, mode) do
    [key1, key2, key3] = generate(key)
    case mode == :des3_ecb do
      true -> data = :crypto.crypto_one_time(:des_ecb, key1, data, encrypt: true)
        data = :crypto.crypto_one_time(:des_ecb, key2, data, encrypt: false)
        :crypto.crypto_one_time(:des_ecb, key3, data, encrypt: true)
      false -> :crypto.crypto_one_time(mode, [key1, key2, key3], data, encrypt: true)
    end

  end

  def decrypt(data, key, mode) do
    [key1, key2, key3] = generate(key)
    case mode == :des3_ecb do
      true -> data = :crypto.crypto_one_time(:des_ecb, key3, data, encrypt: false)
        data = :crypto.crypto_one_time(:des_ecb, key2, data, encrypt: true)
        :crypto.crypto_one_time(:des_ecb, key1, data, encrypt: false)
      false -> :crypto.crypto_one_time(mode, [key1, key2, key3], data, encrypt: false)
    end

  end

  def encrypt(data, key, ivec, mode) do
    [key1, key2, key3] = generate(key)
    case mode == :des3_ecb do
      true -> encrypt(data, key, mode)
      false -> :crypto.crypto_one_time(mode, [key1, key2, key3], ivec, data, encrypt: true)
    end
  end

  def decrypt(data, key, ivec, mode) do
    [key1, key2, key3] = generate(key)
    case mode == :des3_ecb do
      true -> decrypt(data, key, mode)
      false -> :crypto.crypto_one_time(mode, [key1, key2, key3], ivec, data, encrypt: false)
    end
  end

  def generate(key) when is_binary(key) do
    if rem(byte_size(key), 8) != 0 do
      raise :erlang.error(:not_support)
    end
    case div(byte_size(key), 8) do
      0 -> :erlang.error(:not_support)
      1 -> [String.slice(key, 0, 8), String.slice(key, 0, 8), String.slice(key, 0, 8)]
      2 -> [String.slice(key, 0, 8), String.slice(key, 8, 8), String.slice(key, 0, 8)]
      _ -> [String.slice(key, 0, 8), String.slice(key, 8, 8), String.slice(key, 16, 8)]
    end
  end
end
