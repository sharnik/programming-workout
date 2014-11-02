product list =
  case list of
    [] -> 1
    head::tail -> head * product tail

product [1, 2, 3, 4]


multiply x y = x * y
multiply_by_6 x = multiply 6 * x

multiply_by_6 8

return_x list = map (\point -> point.x ) list

return_x [{x = 3}, {x = 2}, {x = 1}]


persons = [
    {name = "John", age = 18, address = {city = "Berlin", country = "DE"}},
    {name = "Joe", age = 12, address = {city = "Berlin", country = "DE"}},
    {name = "Jane", age = 21, address = {city = "Berlin", country = "DE"}}
]
young list = filter (\person -> (person.age > 16)) list

young persons