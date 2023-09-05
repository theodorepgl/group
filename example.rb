# if element == 0
# end

class SudokuPuzzle
    def initialize(board)
        @board = board
    end

    attr_reader :board

    def solve!
        while !complete?
            @board.each do |row|
                row.each_with_index do |number, index|
                    if number.zero?
                        row[index] = 1 # can't put 0
                        # get the list of all already listed value (horizontal, vertical, 3x3 box)
                        # get the list of all potential values
                        # if there is only one potential value, that value must belong in that box
                        # if not, then we can't speculate, so we must move onto the next box
                        # repeat overr and over until all of the zeroes are gone. Hi im here hehe.

                        horizontal_values = row
                        vertical_values = board.map { |board_row| board_row[index]}
                    end
                end
            end
        end
    end

    def complete?
        @board.flatten.none?(&:zero?)
    end

    private

    def horizontal_values
    end

    def vertical_values
    end

    # 3x3 box
    def box_value
    end


end

board = [
  [0, 1, 5, 0, 0, 3, 0, 0, 2],
  [0, 0, 0, 1, 0, 0, 9, 0, 6],
  [2, 7, 0, 0, 6, 8, 4, 3, 0],
  [4, 9, 0, 0, 0, 2, 0, 1, 7],
  [5, 0, 1, 0, 4, 0, 3, 8, 0],
  [0, 0, 3, 9, 0, 5, 0, 0, 0],
  [9, 0, 0, 0, 8, 1, 0, 4, 0],
  [8, 6, 0, 0, 7, 0, 0, 2, 5],
  [0, 3, 7, 2, 0, 4, 6, 0, 0]
]

puzzle = SudokuPuzzle.new(board)
puzzle.solve!
pp puzzle.board