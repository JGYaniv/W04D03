require_relative "piece" 
require_relative "../board.rb"
require_relative "steppable"

class King < Piece
    include Steppable

    def moves
      possible_moves =  move_diffs.map do |diffs|
            [(diffs.first + self.pos.first), (diffs.last + self.pos.last)]
        end  
        possible_moves.select {|position| valid?(position) && !allied_piece?(position)}
    end

    def symbol
        @symbol = :K
    end

    private 

    def move_diffs
        [
            [1,0],
            [0,1],
            [1,1],
            [-1,0],
            [0,-1],
            [-1,-1],
            [1,-1],
            [-1,1]
        ]
    end

end