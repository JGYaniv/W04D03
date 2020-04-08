require_relative "piece"
require_relative "slideable"

class Bishop < Piece
    include Slideable

    def move_diffs
        DIAGONAL_DIRS
    end
    def symbol
        @symbol = :B
    end
end