defmodule MyList do

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def mapsum(list, func), do: sum(map(list, func))

  def max(list), do: _max(list, 0)

  defp _max([], maximum), do: maximum
  defp _max([head | tail], maximum) when head > maximum, do: _max(tail, head)
  defp _max([head | tail], maximum) when head <= maximum, do: _max(tail, maximum)

  def caesar([], _n), do: []
  def caesar([head | tail], n) when head + n <= ?z, do: [head + n | caesar(tail, n)]
  def caesar([head | tail], n) when head + n > ?z, do: [rem(head + n, 122) + 96 | caesar(tail, n)]

  def span(from, from), do: [from]
  def span(from, to), do: [from | span(from + 1, to)]
end

IO.puts "Sum [1, 2, 3]: #{MyList.sum([1, 2, 3])}"
IO.puts "Map (square) [1, 2, 3]: #{MyList.map([1, 2, 3], &(&1 * &1))}"
IO.puts "Mapsum (square) [1, 2, 3]: #{MyList.mapsum([1, 2, 3], &(&1 * &1))}"
IO.puts "Max [1, 2, 3]: #{MyList.max([2, 3, 1])}"

IO.puts MyList.caesar('xhejn', 13)
IO.puts inspect(MyList.span(1,3))