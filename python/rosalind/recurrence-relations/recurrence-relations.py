def rabinacci(old, young, reproduction_rate, months):
    result = None
    if months == 1:
        result = young
    else:
        result = rabinacci(young, old * reproduction_rate + young, reproduction_rate, months - 1)

    return result

f = open("input.txt", "r")
array = f.readlines()

input = array[0].split()
months = int(input[0])
reproduction_rate = int(input[1])

print rabinacci(0, 1, reproduction_rate, months)
