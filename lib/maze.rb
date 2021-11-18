class Maze
  def self.from_file(file)
    File.readlines(file).map do |line|
      line.chomp.split("")
    end
  end

  attr_reader :maze

  def initialize(file)
    @maze        = Maze.from_file(file)
    @start_point = []
    @end_point   = []
  end

  def find_start
    @maze.each_with_index do |line, idx1|
      line.each_with_index do |ele, idx2|
        if ele == "S"
          @start_point << idx1
          @start_point << idx2
        end
      end
    end
    @start_point
  end

  def find_end
    @maze.each_with_index do |line, idx1|
      line.each_with_index do |ele, idx2|
        if ele == "E"
          @end_point << idx1
          @end_point << idx2
        end
      end
    end
    @end_point
  end

end
