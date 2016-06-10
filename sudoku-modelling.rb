class Sudoku
    def initialize(board_string)
        @horizontal_arr = board_string.to_s.split("").map { |digit| digit.to_i }
        @board_horizontal = @horizontal_arr.each_slice(9).to_a
        @board_squares = []
        square_arr = @board_horizontal.dup
        3.times do
            3.times do
                temp_board = []
                for i in (0..2)
                    selected = square_arr[i].take(3)
                    selected.each {|x| temp_board << x}
                    square_arr[i] = square_arr[i].drop(3)
                end
                @board_squares << temp_board
            end
            square_arr = square_arr.drop(3)
        end
        @counter = @horizontal_arr.count(0)
    end
    
    def locate(value)
        x = value / 9
        y = value % 9
        if x < 3
            return @board_squares[0] if y < 3
            return @board_squares[1] if y < 6
            return @board_squares[2] if y < 9
            elsif x < 6
            return @board_squares[3] if y < 3
            return @board_squares[4] if y < 6
            return @board_squares[5] if y < 9
            elsif x < 9
            return @board_squares[6] if y < 3
            return @board_squares[7] if y < 6
            return @board_squares[8] if y < 9
        end
    end
    
    def solve!
        until @counter == 0
            @counter = @horizontal_arr.count(0)
            zeros = []
            @horizontal_arr.each_with_index {|value, place| zeros << place if value == 0}
            zeros.each do |x|
                possible = [1, 2, 3, 4, 5, 6, 7, 8, 9]
                possible -= @board_horizontal[x/9]
                possible -= @board_horizontal.transpose[x%9]
                position = locate(x)
                possible -= position
                if possible.length == 1
                    @board_horizontal[x/9][x%9] = possible[0]
                    @counter -= 1
                    zeros -= [x]
                end
            end
            @horizontal_arr = @board_horizontal.flatten
        end
    end
    
    # Returns a string representing the current state of the board
    # Don't spend too much time on this method; flag someone from staff
    # if you are.
    def board
        @board_horizontal.flatten.join("")
    end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
#board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(105802000090076405200400819019007306762083090000061050007600030430020501600308900)

# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board