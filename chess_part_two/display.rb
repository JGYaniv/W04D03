require "colorize"
# require_relative "board" #does this work?
require_relative "cursor"

class Display  

    def initialize (board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def run
        render
        until @cursor.get_input == 0
            system("clear")
            render
        end
    end
    
    def render
        @board.board.each_with_index do |row, row_idx|
            mapped_row = []
            row.each_with_index do |p, p_idx|
                piece = p.symbol.to_s.colorize(p.color)

                if p.is_a?(NullPiece) && @cursor.cursor_pos == [row_idx, p_idx]
                    mapped_row << "-".colorize(:color=> p.color, :background => :blue)
                elsif p.pos == @cursor.cursor_pos 
                    mapped_row << piece.colorize(:color => p.color, :background => :blue)
                else
                    mapped_row << piece
                end
            end
            puts mapped_row.join(" ")
        end
        true
    end
end
