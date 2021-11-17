class Maze
  def self.from_file(file)
    maze = File.readlines(file).map do |line|
      [line.chomp.split("")]
    end
  end

  def initialize(file)
    @maze        = Maze.from_file(file)
    @start_point = []
    @end_point   = []
  end
end
