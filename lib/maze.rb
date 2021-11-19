class Maze
  DELTAS = [[1, 0], [0, 1],[-1, 0], [0, -1]]
  
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

  def is_wall?(indices)
    row, col = indices
    @maze[row][col] == "*"
  end

  def path
    start_row, start_col = @start_point
    end_row  , end_col   = @end_point
  end
end
