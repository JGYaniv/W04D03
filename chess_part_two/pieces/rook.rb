require_relative "piece" 
require_relative "../board.rb"
require_relative "slideable.rb"

class Rook < Piece
    include Slideable

    def move_diffs
        HORIZONTAL_DIRS
    end

    def symbol
        @symbol = :R
    end
end

# load 'rook.rb'
# b = Board.new
# r1 = Queen.new([2,2],b)
# r1 = Rook.new([2,0],b)
# r1 = Rook.new([0,2],b)
# r1 = Rook.new([0,0],b)
# r1 = Rook.new([4,4],b)
# r1 = Rook.new([0,4],b)
# r1 = Rook.new([4,4],b)