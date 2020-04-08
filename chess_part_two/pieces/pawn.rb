require_relative 'piece'
require_relative 'steppable'

class Pawn < Piece
    include Steppable

    def symbol
        @symbol = :P
    end

    def moves
        possible_move = []
        forward_dir = [pos.first + forward_dirs.first, pos.last]
        possible_move << forward_dir unless has_piece?(forward_dir) 
        attack_dirs.each do |dir|
            attack_dir = [pos.first + dir.first, pos.last + dir.last]
            possible_move << attack_dir if valid?(attack_dir) && enemy_piece?(attack_dir)
        end
        possible_move
    end

    private
    def forward_dirs
        if @color == :white
            return [1,0]
        else
            return [-1,0]
        end
    end

    def attack_dirs
        if @color == :white
            return [[1,1],[1,-1]]
        else
            return [[-1,-1],[-1,1]]
        end
    end

end
