require_relative 'piece'
require 'singleton'

class NullPiece < Piece
    include Singleton

    def initialize
        @color = :gray
    end

    def symbol
        @symbol = :-
    end
end