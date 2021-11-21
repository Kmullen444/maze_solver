class Maze
 DELTA = [[1,0], [0,1], [-1,0], [0, -1]]
  
  def self.from_file(file)
    File.readlines(file).map do |line|
      line.chomp.split("")
    end
  end

  attr_reader :maze

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

  def wall_indices 
    maze.map.with_index do |line, idx1|
      line.select.with_index do |ele, idx2|
        [idx1, idx2] if is_wall?(idx1, idx2)
      end
    end
  end

  def possible_path 
    path = []

    maze.map.with_index do |line, idx1|
      line.each.with_index do |ele, idx2|
        path << [idx1, idx2] if !is_wall?(idx1, idx2)
      end
    end
   path
  end
  
  def neighbors(pos)
    row, col = pos
    DELTA.map { |p_x, p_y| [p_x + row, p_y + col] }
  end
  
  def [](pos)
    row, col = pos
    @maze[row][col] 
  end 


  # needs to start at the starting point
  # from there need to check the neighbors and if one isn't a wall
  # put a X there and puts those indice into a hash to make sure
  # you aren't going back

  #TODO: refactor path


  def path
    postition = @start_point
    copy_maze = maze.dup
    been_there = []
    until postition == @end_point do 
      pos_neighbors = neighbors(postition)
      pos_neighbors.each do |coords|
        row, col = coords
        if !is_wall?(row, col) && !been_there.include?(coords)
          postition = coords
          been_there << coords 
          if @maze[row][col] == " " 
            copy_maze[row][col] = "X" 
          else
            copy_maze[row][col]
          end
        end
      end
    end 
    copy_maze
  end

  def show_maze(maze)
    maze.each do |line|
      puts line.join(" ")
    end

  end
end
