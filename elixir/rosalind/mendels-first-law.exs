defmodule Rosalind do

  def compute([dominant, hetero, recessive]) do
    total = dominant + hetero + recessive
    1 -
      recessive / total * (recessive - 1) / (total - 1) -
      hetero / total * recessive / (total - 1) * 1 / 2 -
      recessive / total * hetero / (total - 1) * 1 / 2 -
      hetero / total * (hetero - 1) / (total - 1) * 1 / 4
  end
end

result = IO.read(:line) |> String.split |> Enum.map(&binary_to_integer(&1)) |> Rosalind.compute
:io.format("~.5f\n", [result])
