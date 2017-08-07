def pascal_triangle(max_row_idx)
triangle = []
  max_row_idx.times do |r_idx|
    row = []
    r_idx.times { |p_idx| row << pascal_at(r_idx, p_idx) }
    triangle << row.dup
  end
  triangle
end

def pascal_at(row, pos)
  fact(row)/(fact(pos - 1) * fact(row - pos - 1))
end

def fact(n)
  return 1 if (0..1).cover?(n)
  (2..n).to_a.reduce(:*)
end
