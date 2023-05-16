threshold = 10

function(bins, threshold) {

intervals = []
for i in range(0, length(bins)):
  bin_i = bins[i]
  if bin_i > threshold:
    for j in range(i, length(bins)):
      bin_j = bins[j]
      if bin_j <= threshold:
        intervals.append((i,j))
        i = j
        break

}