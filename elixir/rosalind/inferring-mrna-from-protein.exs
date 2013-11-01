defmodule Rosalind do

  defp reverse_codon_table do
    [
      F: 2, L: 6, I: 3, V: 4, A: 4, T: 4, P: 4, S: 6, M: 1, H: 2, E: 2, G: 4,
      R: 6, K: 2, D: 2, N: 2, Q: 2, Y: 2, C: 2, W: 1
    ]
  end

  def compute_mrna_possibilities([]), do: 3
  def compute_mrna_possibilities([ head | tail]) do
    head_value = Dict.get(reverse_codon_table, list_to_atom([head]))
    tail_value = compute_mrna_possibilities(tail)
    rem(head_value * tail_value, 1_000_000)
  end
end

IO.read(:line) |> String.strip |> to_char_list
  |> Rosalind.compute_mrna_possibilities
  |> inspect |> IO.puts