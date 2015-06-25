winner = false
tie_game = false
winning_moves = {1 => [1,2,3], 2 => [4,5,6], 3 => [7,8,9], 4 => [1,4,7], 5=> [2,5,8], 6 => [3,6,9], 7 => [1,5,9], 8 => [3,5,7] }


def initialize_board
  board = {}  
  (1..9).each{ |p| board[p] = " "}
  board
end


def available_moves(board)
  board.select{|k,v| v.strip.empty? }.keys
end


def predict_move(board, player_key, winning_move)
  board_posotion = 0

  moves = winning_move.values  
  moves.each_with_index do |item,idx|
    count = 0
    potential_move = 0
    item.each_with_index do |sqr, ind| 
      if board[sqr].eql?(player_key) 
        count = count + 1
      elsif board[sqr].eql?("o") 
        count = count - 1  
      else
        potential_move = sqr
      end  
      if ind == 2 && count == 2
        board_posotion = potential_move
        break
      end 
    end
    break if count == 2
  end 
  board_posotion
end

def isWinner?(board, player_key, winning_move)
  count = 0
  winning_move.each do |k,v|
    count = 0
    v.each_with_index do |pos, idx| 
      if board[pos].eql?(player_key)
        count = count + 1
        return true if count == 3
      end
    end
  end
  count == 3
end

def draw_board(board)
  puts " #{board[1]} | #{board[2]} | #{board[3]}"
  puts "------------"
  puts " #{board[4]} | #{board[5]} | #{board[6]}"
  puts "------------"
  puts " #{board[7]} | #{board[8]} | #{board[9]}"
end


def players_move(board)
  puts "Your move: "
  board_choice = gets.chomp.downcase

  until available_moves(board).include?(board_choice.to_i) do
    puts "That posistion is already taken."
    board_choice = gets.chomp.downcase
  end 
  
  board[board_choice.to_i] = "x"
end

def draw_instruction_board
  puts "Enter 1 - 9 for your posistion on the board."
  puts " #{1} | #{2} | #{3}"
  puts "------------"
  puts " #{4} | #{5} | #{6}"
  puts "------------"
  puts " #{7} | #{8} | #{9}"
end


def comptuer_move(board, move)
  if move == 0
    remainging_moves = available_moves(board)
    move = remainging_moves.sample
  end
  board[move] = "o"
end


#Start the game!
game_board = initialize_board
run_once = true

begin

  if(run_once)
    draw_instruction_board
    run_once = false
  end

  if(!available_moves(game_board).empty?)
    players_move(game_board) 
    if(isWinner?(game_board, "x",winning_moves))
      puts "Congratulations! You win!"
      winner = true
    elsif isWinner?(game_board, "o",winning_moves)
      puts "Computer wins! Better luck next time."
      winner = true
    else
      move = predict_move(game_board,"x", winning_moves) 
      comptuer_move(game_board, move)  
    end
  else
    puts
    puts "It's a tie!"
    tie_game = true
  end
  
  draw_board(game_board)

end until winner || tie_game




