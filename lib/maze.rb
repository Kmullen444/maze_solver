class Maze
  def self.from_file(file)
    File.readlines(file).map do |line|
      [line.chomp.split("")]
    end
  end

  def initialize(file)
    @maze        = Maze.from_file(file)
    @start_point = []
    @end_point   = []
  end

  def find_start
    start_indices = []
    @maze.each_with_index do |line, i|
      line.select.with_index do |ele, idx2|
        start_indices << [i][idx2] if ele == "S"
      end
    end
    start_indices
  end
end
