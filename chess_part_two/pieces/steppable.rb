
module Steppable
    def valid?(pos)

        self.board.valid_pos?(pos) #self.board = Board ; pos => [0,0]
    end

    def allied_piece?(pos)
        return false unless valid?(pos)
        piece = self.board[pos]
        return false if piece.is_a?(NullPiece)
        piece.color == self.color 
    end

    def enemy_piece?(pos)
        return false unless valid?(pos)
        piece = self.board[pos]
        return false if piece.is_a?(NullPiece)
        piece.color != self.color
    end

    def has_piece?(pos)
        return false unless valid?(pos)
        !self.board[pos].is_a?(NullPiece)
    end
end