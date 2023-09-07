require 'colorize'

def display_grid(grid)
  grid.each { |row| puts row.join(' ') }
end

def is_valid_move(grid, row, col, num)
  # Check if the number is not already present in the current row or column
  (0..8).each do |i|
    return false if grid[row][i] == num || grid[i][col] == num
  end

  # Check if the number is not already present in the 3x3 subgrid
  start_row, start_col = 3 * (row / 3), 3 * (col / 3)
  (0..2).each do |i|
    (0..2).each do |j|
      return false if grid[start_row + i][start_col + j] == num
    end
  end

  true
end

def solve_sudoku(grid)
  empty_cell = find_empty_cell(grid)
  
  # If there are no empty cells, the puzzle is solved
  return true unless empty_cell
  
  row, col = empty_cell
  
  (1..9).each do |num|
    if is_valid_move(grid, row, col, num)
      grid[row][col] = num
      
      # Recursively try to solve the puzzle
      if solve_sudoku(grid)
        return true
      end
      
      # If placing num doesn't lead to a solution, backtrack
      grid[row][col] = 0
    end
  end
  
  false
end

def find_empty_cell(grid)
  (0..8).each do |row|
    (0..8).each do |col|
      return [row, col] if grid[row][col] == 0
    end
  end
  nil
end

def is_valid_sudoku(grid)
  # Check each row, column, and 3x3 subgrid for duplicates
  (0..8).each do |i|
    return false if has_uniq(grid[i]) || has_uniq(grid.map { |row| row[i] }) || has_uniq(subgrid(grid, i))
  end
  true
end

def has_uniq(arr)
  arr.reject { |x| x == 0 }.uniq.length != arr.reject { |x| x == 0 }.length
end

def subgrid(grid, i)
  row_start = (i / 3) * 3
  col_start = (i % 3) * 3
  result = []
  (0..2).each do |row_offset|
    (0..2).each do |col_offset|
      result << grid[row_start + row_offset][col_start + col_offset]
    end
  end
  result
end

# Input the Sudoku grid as a string (81 characters)
input_grid = "015003002000100906270068430490002017501040380003905000900081040860070025037204600"

# Convert the string into a 2D array
grid = input_grid.chars.each_slice(9).map { |row| row.map(&:to_i) }
puts "\n"
puts "Default Sudoku Problem:".light_blue
display_grid(grid)
puts "\n"

if solve_sudoku(grid) && is_valid_sudoku(grid)
  puts "Solved Sudoku:".light_blue
  display_grid(grid)
else
  puts "No solution found."
end