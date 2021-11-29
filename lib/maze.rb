class Maze

   @@deltas = [[1,0], [0,1], [-1,0], [0, -1]].freeze
  
  def self.from_file(file)
    File.readlines(file).map do |line|
      line.chomp.split("")
    end
  end

  attr_reader :start_point, :end_point, :maze

  def initialize(file)
    @maze        = Maze.from_file(file)
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
    indices = []
    maze.each_with_index do |line, idx1|
      line.each_with_index do |ele, idx2|
        if ele == letter
          indices << idx1 
          indices << idx2
        end
      end
    end
    indices
  end

  def is_wall?(row, col)
    @maze[row][col] == "*"
  end
  
  def neighbors(pos)
    row, col = pos
    neighbors = []
    @@deltas.each do |d_x,d_y| 
      neighbor = [( d_x + row ) ,( d_y + col )] 
      neighbors << neighbor if !is_wall?(neighbor.first, neighbor.last)
    end
    neighbors
  end

  def path
   position = @start_point
   been_there = [@start_point]
   possible_path = [] 

   until position == @end_point
     pos_neighbors = neighbors(position)

     pos_neighbors.each do |coords|
       row, col = coords

      if !been_there.include?(coords)

        if @maze[row][col] == " "
          possible_path << coords
        end

        been_there << coords
        position = coords
      end
    end
   end
   possible_path
  end

  def make_path(path)
    copy_maze = @maze.dup

    path.each do |coords|
      row, col = coords
      copy_maze[row][col] = "X"
    end

    copy_maze
  end


  def show_maze(maze = self.make_path(path))
    maze.each do |line|
      puts line.join("")
    end
  end

  def distance(pos)
    row, col = pos
    end_row, end_col = @end_point
    ((row - end_row) + (col - end_col)).abs
  end

  def distance_for_path(path)
    distance_of_path = Hash.new { |k,v| hash[k] = v } 

    path.each do |coords|
      distance_of_path[coords] = distance(coords) 
    end
    distance_of_path
  end

  def choose_path
    distances = distance_for_path(self.path) 
    pos_path = []

    distances.value 
  end

end




if $PROGRAM_NAME == __FILE__
  maze = Maze.new("maze1.txt")
  maze.show_maze
end
