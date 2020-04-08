require_relative "piece" 
require_relative "../board.rb"
require_relative "steppable"

class Knight < Piece
    include Steppable

    def moves
      possible_moves =  move_diffs.map do |diffs|
            [(diffs.first + self.pos.first), (diffs.last + self.pos.last)]
        end  
        possible_moves.select {|position| valid?(position) && !allied_piece?(position)}
    end
    
    def symbol
        @symbol = :H
    end

    private 

    def move_diffs
        [
            [2,1],
            [1,2],
            [2,-1],
            [-1,2],
            [-2,1],
            [1,-2],
            [-1,-2],
            [-2,-1]
        ]
    end

end