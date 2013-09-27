defmodule Rosalind do

  defp codon_table do
    [
      UUU: "F",       CUU: "L",      AUU: "I",      GUU: "V",
      UUC: "F",       CUC: "L",      AUC: "I",      GUC: "V",
      UUA: "L",       CUA: "L",      AUA: "I",      GUA: "V",
      UUG: "L",       CUG: "L",      AUG: "M",      GUG: "V",
      UCU: "S",       CCU: "P",      ACU: "T",      GCU: "A",
      UCC: "S",       CCC: "P",      ACC: "T",      GCC: "A",
      UCA: "S",       CCA: "P",      ACA: "T",      GCA: "A",
      UCG: "S",       CCG: "P",      ACG: "T",      GCG: "A",
      UAU: "Y",       CAU: "H",      AAU: "N",      GAU: "D",
      UAC: "Y",       CAC: "H",      AAC: "N",      GAC: "D",
      UAA: "",        CAA: "Q",      AAA: "K",      GAA: "E",
      UAG: "",        CAG: "Q",      AAG: "K",      GAG: "E",
      UGU: "C",       CGU: "R",      AGU: "S",      GGU: "G",
      UGC: "C",       CGC: "R",      AGC: "S",      GGC: "G",
      UGA: "",        CGA: "R",      AGA: "R",      GGA: "G",
      UGG: "W",       CGG: "R",      AGG: "R",      GGG: "G"
    ]
  end

  def translate([]), do: []
  def translate('\n'), do: []
  def translate([ head_a, head_b, head_c | tail ]) do
    [
      Dict.get(codon_table, list_to_atom([head_a, head_b, head_c])) |
      translate(tail)
    ]
  end
  def translate(any), do: IO.puts "Unexpected input: #{inspect any}."
end

IO.read(:stdio, :line)
  |> to_char_list
  |> Rosalind.translate
  |> to_string
  |> IO.write