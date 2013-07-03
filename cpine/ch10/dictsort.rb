# the suggested method seems like O(n^2), so opting for a O(n log n) qsort instead
def dictsort ary
  if ary.length < 2
    return ary
  end
  pivot = ary[(pivot_idx = rand(ary.length))]
  lo = []
  hi = []
  (0...ary.length).each { |i|
    if i != pivot_idx
      (compare(ary[i], pivot) <= 0 ? lo : hi) << ary[i]
    end 
  }
  sort(lo) + [pivot] + sort(hi)
end

def compare a, b
  a.downcase <=> b.downcase 
end
