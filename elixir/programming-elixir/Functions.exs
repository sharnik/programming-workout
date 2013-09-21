# Exercise 1:
list_concat = fn (a, b) -> a ++ b end
sum = fn (a, b, c) -> a + b + c end
pair_tuple_to_list = fn {a, b} -> [a, b] end

# Exercise 2:
internal_fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end
external_fizz_buzz = fn
  n -> internal_fizz_buzz.(rem(n, 3), rem(n, 5), "#{n}")
end
IO.puts external_fizz_buzz.(10)
IO.puts external_fizz_buzz.(11)
IO.puts external_fizz_buzz.(12)
IO.puts external_fizz_buzz.(13)
IO.puts external_fizz_buzz.(14)
IO.puts external_fizz_buzz.(15)
IO.puts external_fizz_buzz.(16)

prefix = fn str_a -> (fn str_b -> "#{str_a} #{str_b}" end) end
mrs = prefix.("Mr.")
IO.puts mrs.("Hyde")
IO.puts prefix.("Elixir").("kinda rocks")

Enum.map [1, 2, 3, 4], &1 + 2
Enum.each [1,2, 3, 4], &(IO.puts("#{&1}"))