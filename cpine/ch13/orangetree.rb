class OrangeTree
  def initialize
    @height = 0
    @age = 0
    @orange_count = 0
  end
  def height
    @height
  end
  def one_year_passes
    if @age > 15
      puts "tree has died"
      @height = 0
      @orange_count = 0
    else
      @height += 2
      @age += 1
      @orange_count = [0, @age - 4].max
    end
  end
  def count_the_oranges
    @orange_count
  end
  def pick_an_orange
    if @orange_count > 0
      puts "here, have an orange"
      @orange_count -= 1
    else
      puts "no more oranges!"
    end
  end
end
