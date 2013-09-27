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

defmodule MyEnum do
  def all?([], _func), do: true
  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  def each([elem], func), do: func.(elem)
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split(list, count), do: _split(list, [], count)
  defp _split(first_list, second_list, 0), do: { first_list, second_list }
  defp _split([head | tail], list, count), do: _split(tail, [head | list], count - 1)

  def take(list, 0), do: []
  def take([head | tail], count), do: [head | take(tail, count - 1)]

  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head) do
    flatten(head) ++ flatten(tail)
  end
  def flatten([head | tail]) do
    [head | flatten(tail)]
  end


end

IO.puts inspect(MyEnum.all?([1, 2, 3], &(&1 > 1)))
MyEnum.each(['bla1', 'bla2', 'bla3'], &(IO.puts(&1)))
IO.puts inspect(MyEnum.filter([2, 1, 3], &(&1 > 1)))
IO.puts inspect(MyEnum.split([2, 1, 3], 2))
IO.puts inspect(MyEnum.take([2, 1, 3], 2))
IO.puts inspect(MyEnum.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]]))

# Use your span function and list comprehensions to return a list of the prime numbers from 2 to n.
IO.puts inspect( MyList.span(2, 10) -- (
  lc x inlist MyList.span(2, 10), y inlist MyList.span(2,10), x <= y, do: x * y
))

tax_rates_org = [ NC: 0.075, TX: 0.08 ]
orders_org = [
         [ id: 123, ship_to: :NC, net_amount: 100.00 ],
         [ id: 124, ship_to: :OK, net_amount:  35.50 ],
         [ id: 125, ship_to: :TX, net_amount:  24.00 ],
         [ id: 126, ship_to: :TX, net_amount:  44.80 ],
         [ id: 127, ship_to: :NC, net_amount:  25.00 ],
         [ id: 128, ship_to: :MA, net_amount:  10.00 ],
         [ id: 129, ship_to: :CA, net_amount: 102.00 ],
         [ id: 120, ship_to: :NC, net_amount:  50.00 ]
]

defmodule Order do
  def calculate_total(_tax_rates, []), do: []
  def calculate_total(tax_rates, [head | tail]) do
    if head[:ship_to] in Dict.keys(tax_rates) do
      [
        Dict.put(head, :total_amount, (head[:net_amount] * (1.0 + tax_rates[head[:ship_to]]))) |
        calculate_total(tax_rates, tail)
      ]
    else
      [head | calculate_total(tax_rates, tail)]
    end
  end
end

IO.puts(inspect(Order.calculate_total(tax_rates_org, orders_org)))
