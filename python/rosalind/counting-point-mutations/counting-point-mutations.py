f = open("input.txt", "r")
array = f.readlines()

string_a = array[0]
string_b = array[1]

distance = 0
for k in range(len(string_a)):
    if string_a[k] != string_b[k]:
        distance = distance + 1

print distance
