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

  def neighbors(position)
    neighbors = []
    p_y, p_x = position
    DELTAS.each do |coords|
      d_y, d_x = coords
      neighbors << [(d_y + p_y), (d_x + p_x)] if !wall?((d_y + p_y), (d_x + p_x))
    end
    neighbors
  end

  def path
    position = start_point
    copy_maze = @maze.dup
    been_there = []

    until position == end_point
      pos_dir = neighbors(position)

      pos_dir.each do |coords|
        if !been_there.include?(coords)
          been_there << coords
          position = coords
          copy_maze[coords.first][coords.last] = "X"
          break
        end
      end
    end
    copy_maze
  end

end 


if $PROGRAM_NAME == __FILE__
  maze = Maze.new
  maze.show_maze(maze.path)
end
