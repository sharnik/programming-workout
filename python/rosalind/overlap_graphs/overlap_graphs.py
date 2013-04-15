f = open("input.txt", "r")
array = f.readlines()

nodes = {}
for k in range(len(array) / 3):
    nodes[array[3*k].strip('\n >')] = array[3*k+1].strip() + array[3*k+2].strip()

edges = []
for node, dna in nodes.items():
    for other_node, other_dna in nodes.items():
        if dna == other_dna:
            continue
        if dna.endswith(other_dna[:3]):
            edges.append([node, other_node])

for edge in edges:
    print edge[0] + ' ' + edge[1]