class Piece
    attr_reader :board , :color, :pos

    def initialize(pos, board, color = :white)
        @board = board #board class instance
        @color = color
        @pos = pos
        @symbol = :p
    end

    def pos=(val)
        @pos = val
    end

    def move_into_check?(end_pos)
        board_copy = @board.copy
        board_copy.move_piece!(self.pos, end_pos)
        # debugger
        board_copy.in_check?(@color)
    end

    def valid_moves
        moves.reject do |move|
            move_into_check?(move)
        end
    end
end