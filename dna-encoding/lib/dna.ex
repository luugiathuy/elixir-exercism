defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      ?\s -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      0b0000 -> ?\s
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  def decode(dna) do
    do_decode(dna, [])
  end

  defp do_encode([], result), do: result
  defp do_encode([head | tail], result), do: do_encode(tail, <<result::bitstring, encode_nucleotide(head)::4>>)

  defp do_decode(<<>>, result), do: result
  defp do_decode(<<code::4, rest::bitstring>>, result), do: do_decode(rest, result ++ [decode_nucleotide(code)])
end
