defmodule Rosalind do

  def permutations(_, 0), do: [[]]
  def permutations(list, length) do
    lc head inlist list, tail inlist permutations(list, length - 1) do
      [head | tail]
    end
  end

  def combine_permutations(_, 0), do: []
  def combine_permutations(list, n) do
    permutations(list, n) ++ combine_permutations(list, n - 1)
  end

  def compare(_, [], _), do: false
  def compare([], _, _), do: true
  def compare([a | tail_a], [b | tail_b], alphabet) do
    if a == b do
      compare(tail_a, tail_b, alphabet)
    else
      Enum.find_index(alphabet, &1 == a) < Enum.find_index(alphabet, &1 == b)
    end
  end

end

alphabet = IO.read(:line) |> String.split
{length, _} = IO.read(:line) |> String.to_integer

Rosalind.combine_permutations(alphabet, length)
  |> Enum.sort(&(Rosalind.compare(&1, &2, alphabet)))
  |> Enum.each(IO.puts(&1))
