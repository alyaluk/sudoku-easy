class Sudoku
    def initialize(board_string)
        @board_horizontal = []
        horizontal_arr = board_string.to_s.split("").map { |digit| digit.to_i }
        9.times do
            temp_board = []
            selected = horizontal_arr.take(9)
            selected.each {|x| temp_board << x}
            horizontal_arr = horizontal_arr.drop(9)
            @board_horizontal << temp_board
        end
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
        vertical_arr = @board_horizontal.dup
        @board_vertical = []
        9.times do
            temp_board = []
            for i in (0..8)
                selected = vertical_arr[i].take(1)
                selected.each {|x| temp_board << x}
                vertical_arr[i] = vertical_arr[i].drop(1)
            end
            @board_vertical << temp_board
        end
        @squares_x = [[0, 0, 0, 1, 1, 1, 2, 2, 2],
        [0, 0, 0, 1, 1, 1, 2, 2, 2],
        [0, 0, 0, 1, 1, 1, 2, 2, 2],
        [3, 3, 3, 4, 4, 4, 5, 5, 5],
        [3, 3, 3, 4, 4, 4, 5, 5, 5],
        [3, 3, 3, 4, 4, 4, 5, 5, 5],
        [6, 6, 6, 7, 7, 7, 8, 8, 8],
        [6, 6, 6, 7, 7, 7, 8, 8, 8],
        [6, 6, 6, 7, 7, 7, 8, 8, 8]]
        @squares_y = [[0, 1, 2, 0, 1, 2, 0, 1, 2],
        [3, 4, 5, 3, 4, 5, 3, 4, 5],
        [6, 7, 8, 6, 7, 8, 6, 7, 8],
        [0, 1, 2, 0, 1, 2, 0, 1, 2],
        [3, 4, 5, 3, 4, 5, 3, 4, 5],
        [6, 7, 8, 6, 7, 8, 6, 7, 8],
        [0, 1, 2, 0, 1, 2, 0, 1, 2],
        [3, 4, 5, 3, 4, 5, 3, 4, 5],
        [6, 7, 8, 6, 7, 8, 6, 7, 8]]
        @possibilities = Array.new(9){Array.new(9)}
        for i in (0..8)
            for j in (0..8)
                if @board_horizontal[i][j] == 0
                    @possibilities[i][j] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
                end
            end
        end
    end
    
    def solve!
        until @board_horizontal.each.include?(0) == false && @board_vertical.each.include?(0) == false && @board_squares.each.include?(0) == false
            for x in (0..8)
                for y in (0..8)
                    if @board_horizontal[x][y] == 0
                        @board_horizontal.each {|value| @possibilities[x][y].delete(value) if value != 0}
                        if @possibilities[x][y].length == 1
                            @board_horizontal[x][y] = @possibilities[x][y][0].dup
                            @board_vertical[y][x] = @possibilities[x][y][0].dup
                            @board_squares[@squares_x[x]][@squares_y[y]] = @possibilities[x][y][0].dup
                        end
                    end
                    if @board_vertical[x][y] == 0
                        @board_vertical.each {|value| @possibilities[y][x].delete(value) if value != 0}
                        if @possibilities[y][x].length == 1
                            @board_horizontal[y][x] = @possibilities[y][x][0].dup
                            @board_vertical[x][y] = @possibilities[y][x][0].dup
                            @board_squares[@squares_x[y]][@squares_y[x]] = @possibilities[y][x][0].dup
                        end
                    end
                    if @board_squares[x][y] == 0
                        @board_squares.each {|value| @possibilities[@squares_x[x]][@squares_y[y]].delete(value) if value != 0}
                        if @possibilities[@squares_x[x]][@squares_y[y]].length == 1
                            @board_horizontal[@squares_x[x]][@squares_y[y]] = @possibilities[@squares_x[x]][@squares_y[y]][0].dup
                            @board_vertical[@squares_x[y]][@squares_y[x]] = @possibilities[@squares_x[x]][@squares_y[y]][0].dup
                            @board_squares[x][y] = @possibilities[@squares_x[x]][@squares_y[y]][0].dup
                        end
                    end
                end
            end
        end
        p @board_horizontal
    end
    
    # Returns a string representing the current state of the board
    # Don't spend too much time on this method; flag someone from staff
    # if you are.
    def board
        
    end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
#board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(619030040270061008000047621486302079000014580031009060005720806320106057160400030)

# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board