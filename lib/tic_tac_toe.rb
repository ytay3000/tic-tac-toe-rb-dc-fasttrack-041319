WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board,index,char)
  board[index] = char
  return board
end

def position_taken?(board,index)
  (board[index]=="X" || board[index]=="O")
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Your move by position 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    board = move(board,index,current_player(board))
    display_board(board)
#    puts "#{board}"
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |spot|
    if !(spot==" "||spot==""||spot==nil)
      count +=1
    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  if count.even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |winplay|
    board_pt = [board[winplay[0]],board[winplay[1]],board[winplay[2]]]
    if board_pt.all?{|i| i=="X"} ||board_pt.all?{|i| i=="O"}
      return winplay
    end
  end
  return false
end

def full?(board)
  if board.none?{|i| i==" "} && board.none?{|i| i==""} && board.none?{|i| i==nil}
    return true
  else
    return false
  end
end

def draw?(board)
  if won?(board)==false && full?(board)==true
    return true
  else 
    return false
  end
end

def over?(board)
  if won?(board).class==Array || draw?(board)==true || full?(board)==true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board).class==Array
    winplay = won?(board)
    return board[winplay[0]]
  end
end

def play(board)
  until over?(board)==true
    player = current_player(board)
    puts "It's player #{player}'s turn."
    turn(board)
    won?(board)
  end
  if won?(board).class==Array
    puts "Congratulations player #{winner(board)}! You won!"
  else
    puts "The game is a draw.  Restart code to play again."
  end
end