class MyTetris < Tetris
  # your enhancements here

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def buttons 
    super
    rotate_half = TetrisButton.new('180', 'lightgreen'){
        @board.rotate_half_u}
    rotate_half.place(35, 50, 127, 501)
  end

  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_half_u})
    @root.bind('c', proc {@board.cheat})
  end


end

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  # class array holding all the pieces and their rotation
  #  x1, y1, x2, y2
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               rotations([[0, 0], [1, 0], [0, 1], [1, 1], [2,1]]), # new square (only needs one)  
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
               rotations([[0, 0], [-1, 0], [0, 0], [0, -1]]),
               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2]]],
               [[[0, 0], [-1, 0], [1, 0], [2, 0], [3,0]], # new long
               [[0, 0], [0, -1], [0, 1], [0, 2], [0,3]]],
               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]])] # Z

  #Square for cheat
  Mini_Square = [[[[0, 0], [0, 0], [0, 0], [0, 0]]]]

  # class method to choose the next piece
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  # class method to choose a square piece
  def self.next_piece_for_cheat(board)
    MyPiece.new(Mini_Square.sample, board)
  end
end

class MyBoard < Board
  
  def initialize (game)
      @grid = Array.new(num_rows) {Array.new(num_columns)}
      @current_block = MyPiece.next_piece(self)
      @score = 0
      @game = game
      @delay = 500
  end  

  # gets the next piece
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  def next_piece_for_cheat
    @current_block = MyPiece.next_piece_for_cheat(self)
    @current_pos = nil
  end

  # your enhancements here
  # rotate 180 grades
  def rotate_half_u
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, -2)
    end
    draw
  end

  #
  def cheat 
    if !game_over? and @game.is_running?
      if @score > 100
        @score -= 100
        next_piece_for_cheat
        @game.update_score
      end
    end
  end
end