defmodule Rosalind do

  def permutations([]), do: [[]]
  def permutations(list) do
    lc head inlist list, tail inlist permutations(list -- [head]) do
      [head | tail]
    end
  end

  def input_to_list(0), do: []
  def input_to_list(n) do
    [n | input_to_list(n - 1)]
  end

  def print([]) do end
  def print([head | tail]) do
    IO.puts(Enum.join(head, " "))
    print(tail)
  end

end

result = Rosalind.permutations(Rosalind.input_to_list(5))
IO.puts("#{length(result)}")
Rosalind.print(result)