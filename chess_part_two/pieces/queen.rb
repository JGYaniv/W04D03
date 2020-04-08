require_relative "piece" 
require_relative "../board.rb"
require_relative "slideable.rb"

class Queen < Piece
    include Slideable

    def move_diffs
        HORIZONTAL_DIRS + DIAGONAL_DIRS
    end

    def symbol
        @symbol = :Q
    end
end

# load 'queen.rb'
# b = Board.new
# r1 = Rook.new([2,0],b)
# r2 = Rook.new([0,2],b,:black)
# r3 = Rook.new([0,4],b)
# b.add_piece(r1, [2,0])
# b.add_piece(r2, [0,2])
# b.add_piece(r3, [0,4])
# q1 = Queen.new([2,2],b)
# q1.moves
