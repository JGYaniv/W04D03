require 'byebug'
module Slideable #is this neccicary as a module? wouldn't make more sense as a superclass.
    DIAGONAL_DIRS = [
      [-1,-1],
      [1,1],
      [1,-1],
      [-1,1]
    ]

    HORIZONTAL_DIRS = [
      [-1,0],
      [1,0],
      [0,-1],
      [0,1]
    ]

    def moves
        
        array = []
        self.move_diffs.each do |dir|
            next_pos = [dir.first + pos.first, dir.last + pos.last]
            # debugger
            while !allied_piece?(next_pos) && valid?(next_pos)
                # debugger
                if enemy_piece?(next_pos)
                    array << next_pos unless next_pos == pos
                    break
                else
                    array << next_pos unless next_pos == pos
                end

                next_pos = [dir.first + next_pos.first, dir.last + next_pos.last]
            end 
        end
        array
    end

    def valid?(pos)
        self.board.valid_pos?(pos)
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
        self.board[pos].is_a?(NullPiece) == false
    end
end

# (0...5).each do |i| #why does return/next/skip not work here?
#   puts i
#   while true
#     v = rand(0..2)
#     break if v == 1
#   end  
# end  