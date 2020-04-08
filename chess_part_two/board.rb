require_relative 'pieces'
require_relative "display"
require 'byebug'

class Board

    attr_reader :board
    attr_writer :board
    def initialize(board=nil)
        @sent = NullPiece.instance
        board ||= Array.new(8){Array.new(8,@sent)}
        @board = board
    end

    def setup
        add_black
        add_white
        add_pawn_rows
        # @display = Display.new(self)
        # @display.run
    end

    def copy #return copy of board instance
        b = Board.new
        copy_board_array = Board.dup_board(@board, b)
        # debugger
        b.board = copy_board_array
        b
    end

    def self.dup_board(board_array, new_board_instance)
        duper = []
        board_array.each do |el|
            if el.is_a?(Array)
                duper << Board.dup_board(el, new_board_instance)
            elsif el.is_a?(NullPiece)
                duper << el
            else
                el.class.new(el.pos, new_board_instance, el.color)
            ##### DON"T DO THIS !!!! #######
            # elsif el.is_a?(Pawn)
            #     duper << Pawn.new(el.pos, new_board_instance, el.color)
            # elsif el.is_a?(Bishop)
            #     duper << Bishop.new(el.pos, new_board_instance, el.color)
            # elsif el.is_a?(Queen)
            #     duper << Queen.new(el.pos, new_board_instance, el.color)
            # elsif el.is_a?(King)
            #     duper << King.new(el.pos, new_board_instance, el.color)
            # elsif el.is_a?(Rook)
            #     duper << Rook.new(el.pos, new_board_instance, el.color)
            # elsif el.is_a?(Knight)
            #     duper << Knight.new(el.pos, new_board_instance, el.color)
            ###################################
            end
        end
        duper
    end

    def add_white 
        row = [
                Rook.new([0,0], self), 
                Knight.new([0,1], self),
                Bishop.new([0,2], self),
                King.new([0,3], self),
                Queen.new([0,4], self),
                Bishop.new([0,5], self),
                Knight.new([0,6], self),
                Rook.new([0,7], self),
            ]

        @board[0] = row
    end

    def add_black
        row = [
            Rook.new([7,0], self,:red),
            Knight.new([7,1], self,:red),
            Bishop.new([7,2], self,:red),
            King.new([7,3], self,:red),
            Queen.new([7,4], self,:red),
            Bishop.new([7,5], self,:red),
            Knight.new([7,6], self,:red),
            Rook.new([7,7], self,:red)
        ]
        
        @board[7] = row
    end

    def add_pawn_rows
        @board.each.with_index do |row,row_idx|
            row.each.with_index do |col, col_idx|
                pos = [row_idx,col_idx]
                if row_idx == 1
                    pawn = Pawn.new(pos,self)
                    self.add_piece(pawn,pos)

                elsif row_idx == 6
                    pawn = Pawn.new(pos,self,:red)
                    self.add_piece(pawn,pos)
                end
            end
        end
    end

    def add_piece(piece, pos) #class instance of piece & pos array
        if valid_pos?(pos)
            @board[pos.first][pos.last] = piece
        end
    end

    def valid_pos?(pos) 
        pos.is_a?(Array) &&
        pos.length == 2 &&
        pos.all? {|el| el.is_a?(Integer)} &&
        (0..7).include?(pos.first) &&
        (0..7).include?(pos.last)
    end

    def find_king(color)
        king = nil
        @board.each do |row|
            row.each do |piece|
                if piece.symbol == :K && piece.color == color
                    king = piece
                end
            end
        end
        king
    end

    def in_check?(color)
        king = find_king(color)
        check_status = false
        @board.each do |row|
            row.each do |piece|
                unless piece.is_a?(NullPiece)
                    check_status = true if piece.moves.include?(king.pos)
                end
            end
        end
        check_status
    end

    def checkmate?(color)
        available_moves = []
        @board.each do |row|
            row.each do |p|
                if p.color == color
                    available_moves += p.valid_moves
                end
            end
        end
        # p available_moves
        available_moves.empty?
    end

    def render 
        @board.each do |row|
            p row.map{|p| p.symbol.to_s}.join(" ")
            puts ""
        end
        true
    end

    def move_piece(start_pos, end_pos, color=nil)
        raise "invalid end position" unless valid_pos?(end_pos)
        raise "invalid start position" unless valid_pos?(start_pos)
        
        
        if self[start_pos]
            piece = self[start_pos]

            unless piece.move.valid_moves.include?(end_pos)
                puts "illegal move"
                return false
            end

            piece.pos = end_pos
            self[end_pos] = piece #add new pos to the piece
            self[start_pos] = @sent
        else
            raise "no piece at start pos"
        end
    end

    def move_piece!(start_pos, end_pos, color=nil)
        raise "invalid end position" unless valid_pos?(end_pos)
        raise "invalid start position" unless valid_pos?(start_pos)
        
        
        if self[start_pos]
            piece = self[start_pos]

            unless piece.moves.include?(end_pos)
                puts "illegal move"
                return false
            end

            piece.pos = end_pos
            self[end_pos] = piece #add new pos to the piece
            self[start_pos] = @sent
        else
            raise "no piece at start pos"
        end
    end

    def [](pos)
        x, y = pos
        @board[x][y]
    end

    def []=(pos, val)
        x, y = pos
        @board[x][y] = val
    end
end

if __FILE__ == $PROGRAM_NAME
    b = Board.new
    b.setup
    b1 = Bishop.new([4,0], b)
    b.add_piece(b1,[4,0])
    # p1 = Pawn.new([5,1], b)
    # b.add_piece(p1,[5,1])
    b.add_piece(NullPiece.instance, [6,2])
    b.add_piece(NullPiece.instance, [6,1])
    # b.add_piece(NullPiece.instance, [6,0])
    # b.move_piece([7,3],[6,2])
    b.render
    # p b[[7,3]].move_into_check?([6,2])

    p b.checkmate?(:red)
    # p p1.moves
    # p p1.valid_moves
    # p b1.moves
    # p b1.valid_moves
    # if b[[7,3]].valid_moves.empty?
    #     puts "checkmate"
    # end
end