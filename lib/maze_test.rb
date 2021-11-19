require "minitest/autorun"
require_relative "./maze"


class TestMaze < Minitest::Test
  def setup
    @test_maze = Maze.new("maze1.txt")
  end

  def test_find_start
    assert_equal [6,1], @test_maze.find_start 
  end
  
  def test_find_end
    assert_equal [1, 14], @test_maze.find_end
  end

  def test_find_letter
    letter = "S"
    assert_equal [6, 1], @test_maze.find_letter(letter)
  end

  def test_is_wall?
    assert @test_maze.is_wall?([0,0])
  end

  def test_path

  end

end

