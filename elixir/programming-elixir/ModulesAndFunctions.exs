defmodule Times do
  def double(n) do
    n * 2
  end

  def triple(n) do
    n * 3
  end

  def quadruple(n) do
    double(n) * 2
  end

end

defmodule AdvMath do

  def sum(0), do: 0
  def sum(n), do: n + sum(n-1)

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

IO.puts "Triple(2): #{Times.triple(2)}"
IO.puts "Quadruple(2): #{Times.quadruple(2)}"

IO.puts "Sum(0): #{AdvMath.sum(0)}"
IO.puts "Sum(5): #{AdvMath.sum(5)}"

IO.puts "GCD(5, 0): #{AdvMath.gcd(5, 0)}"
IO.puts "GCD(5, 7): #{AdvMath.gcd(5, 7)}"
IO.puts "GCD(12, 8): #{AdvMath.gcd(12, 8)}"
IO.puts "GCD(8, 12): #{AdvMath.gcd(8, 12)}"

