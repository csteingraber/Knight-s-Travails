# This class will contain the Knight's
# current position, its origin point 
# and it's next move.
class Knight

  attr_reader :coordinate, :previous_move

  # Takes in a 2-element coordinate array
  # and initializes other instance variable
  # to empty arrays in the time being.
  def initialize(coord = [0, 0], previous_move = nil)
    @coordinate = coord
    @previous_move = previous_move  # Will be used to backtrack and find the path.
    @visited = []                   # Will be used when calculating next moves to
                                    # prevent repetition.
  end

  # Takes in two 2-element arrays that represent
  # the starting coordinate and the ending coordinate.
  # The function prints the series of moves to the 
  # target coordinates.
  def knight_moves(start, target)
    valid_coordinates = valid_coordinate?(start) && valid_coordinate?(target)
    return puts "Invalid coordinates!" unless valid_coordinates
    @coordinate = start
    @visited << start

    knight = find_target(target)

    path = calculate_path_to(knight)

    number_of_moves = path.size - 1
    puts "You made it in #{number_of_moves} moves! Here's your path:"
    path.each do |move|
      p move
    end

    @visited = []
  end

  private

  # Takes in a coordinate and returns true or false.
  # Coordinates must be between 1-8 for both x & y.
  def valid_coordinate?(coord)
    if coord.size == 2 && coord[0].between?(0, 7) && coord[1].between?(0, 7)
      true
    else
      false
    end
  end

  # Takes in a coordinate and calculates all future moves
  # that lie on the board without repeating. 
  def calculate_future_moves(coord)
    possible_transitions = [[2, 1], [2, -1], [1, 2], [-1, 2], 
                            [-2, 1], [-2, -1], [-1, -2], [1, -2]]
    actual_transitions = []
    possible_transitions.each do |transition|
      new_position = [coord[0]+transition[0], coord[1]+transition[1]]
      if valid_coordinate?(new_position) && !@visited.include?(new_position)
        actual_transitions << new_position
      end
    end
    actual_transitions
  end

  def find_target(target)
    queue = [self]
    until queue.empty?
      knight = queue.shift
      break if knight.coordinate == target
      future_moves = calculate_future_moves(knight.coordinate)
      future_moves.each do |move|
        queue.push(Knight.new(move, knight))
        @visited << move
      end
    end
    knight
  end

  def calculate_path_to(knight)
    path = [knight.coordinate]
    until knight.previous_move.nil?
      knight = knight.previous_move
      path.unshift(knight.coordinate)
    end
    path
  end
end

knight = Knight.new
knight.knight_moves([0,0],[1,2])
knight.knight_moves([0,0],[3,3])
knight.knight_moves([3,3],[0,0])
knight.knight_moves([3,3],[3,3])