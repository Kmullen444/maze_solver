require "byebug"
class Maze

  DELTAS = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  attr_reader :start_point, :end_point

  def self.maze_maker(file)
    File. readlines(file).map do |lines|
      lines.chomp.split("")
    end
  end

  def initialize(maze = "maze1.txt")
    @maze        = Maze.maze_maker(maze)
    @start_point = find_start
    @end_point   = find_end
    @been_there  = []
  end

  def find_start
    find_letter("S")
  end

  def find_end
    find_letter("E")
  end

  def find_letter(letter)
    @maze.each_with_index do |line, idx1|
      line.each_with_index do |ele, idx2|
        return [idx1, idx2] if ele == letter
      end
    end
  end

  def show_maze(maze)
    maze.each do |line|
      p line.join
    end
  end

  def wall?(row, col)
    @maze[row][col] == "*"
  end

  def is_valid?(row, col)

    row >= 0 && row < maze_length && col >= 0 && col < maze_length && @maze[row][col] == "X"
  end

  def neighbors(position)
    neighbors = []
    p_y, p_x = position
    DELTAS.each do |coords|
      d_y, d_x = coords
      neighbors << [(d_y + p_y), (d_x + p_x)] if !wall?((d_y + p_y), (d_x + p_x))
    end
    distance(neighbors)
  end

  def maze_length
    @maze[0].length
  end

  def distance(neighbors)
    pos_distances = Hash.new
    neighbors.each do |coords|
      pos_distances[coords] = (coords + end_point).sum
    end
    pos_distances.sort
  end

  def set_position(position)
    pos_position = neighbors(position)

    pos_position.each do |ele|
      return ele.first if !@been_there.include?(ele.first)
    end
  end

  def path
    position = @start_point
    copy_maze = @maze.dup

    until position == end_point
    #  debugger
      if !@been_there.include?(position)
        pos_position = set_position(position)       
        row, col = pos_position
        @been_there << position
        position = pos_position
        copy_maze[row][col] = "X"
      end
    end
    copy_maze
  end



#  def solve_maze
#    @maze.each_with_index do |row, idx1|
#      @maze.each_with_index do |row, idx2|
#        solve_util(idx1, idx2)
#
#      end
#    end
#    show_maze
#  end

#  def solve_util(row, col)
#    if row == end_point.first && col == end_point.last
#      @maze[row][col] = "X"
#      return true
#    end
#
#    if is_valid?(row, col)
#      if @maze[row][col] == "X"
#        return false
#      end
#
#      @maze[row][col] = "X"
#
#      if solve_util(row + 1, col)
#        return true
#      end
#
#      if solve_util(row, col + 1)
#        return true
#      end
#      
#      if solve_util(row - 1, col)
#        return true
#      end
#
#      if solve_util(row, col - 1)
#        return true
#      end
#
#      @maze[row][col] = " "
#      return false
#    end
#    false
#  end

end 
