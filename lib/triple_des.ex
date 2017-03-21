defmodule TripleDes do
  @moduledoc """
  Documentation for TripleDes.
  mode: :des3_ecb, :des3_cbc, des_ede3
  key: iodata, must be a multiple of 64 bits (8 bytes).
  ivec: an arbitrary initializing vector, must be a multiple of 64 bits (8 bytes)
  data: iodata, must be a multiple of 64 bits (8 bytes).
  """

  @doc """
  ## Examples
  """
  def encrypt(data, key, mode) do
    [key1, key2, key3] = generate(key)
    case mode == :des3_ecb do
      true -> data = :crypto.block_encrypt(:des_ecb, key1, data)
        data = :crypto.block_decrypt(:des_ecb, key2, data)
        :crypto.block_encrypt(:des_ecb, key3, data)
      false -> :crypto.block_encrypt(mode, [key1, key2, key3], data)
    end

  end

  def decrypt(data, key, mode) do
    [key1, key2, key3] = generate(key)
    case mode == :des3_ecb do
      true -> data = :crypto.block_decrypt(:des_ecb, key3, data)
        data = :crypto.block_encrypt(:des_ecb, key2, data)
        :crypto.block_decrypt(:des_ecb, key1, data)
      false -> :crypto.block_decrypt(mode, [key1, key2, key3], data)
    end

  end

  def encrypt(data, key, ivec, mode) do
    [key1, key2, key3] = generate(key)
    case mode == :des3_ecb do
      true -> encrypt(data, key, mode)
      false -> :crypto.block_encrypt(mode, [key1, key2, key3], ivec, data)
    end
  end

  def decrypt(data, key, ivec, mode) do
    [key1, key2, key3] = generate(key)
    case mode == :des3_ecb do
      true -> decrypt(data, key, mode)
      false -> :crypto.block_decrypt(mode, [key1, key2, key3], ivec, data)
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
