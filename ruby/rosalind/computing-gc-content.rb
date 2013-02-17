dna_strings = Hash.new('')
string_name = nil
ARGF.read.each_line do |line|
  line.strip!
  if line[0] == '>'
    string_name = line[1..-1]
  else
    dna_strings[string_name] += line
  end
end

gc_counts = {}
dna_strings.each do |name, string|
  gc_counts[name] = string.count('GC') * 100.0 / string.length
end

highest_count_name = string_name
gc_counts.each do |name, value|
  highest_count_name = name if value > gc_counts[highest_count_name]
end

puts highest_count_name
puts gc_counts[highest_count_name]