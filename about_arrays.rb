require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    # inserts integer 2 and index 1
    assert_equal [1, 2], array
    # << inserts values to end of array
    array << 333
    assert_equal [1,2, 333], array
  end

  def test_accessing_array_elements
    # These are symbols. They reduce memory and time by referencing the same object ID only if the
    # characters used match. T
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    # indexes similar to other languages. -1 starts at the end of an array, and goes
    # right to left as the negative indice decreases
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]
    # slicing returns an array based on the first value, the indice and the 
    # second value, the length

    assert_equal [:peanut], array[0,1]
    assert_equal [:peanut,:butter], array[0,2]
    assert_equal [:and,:jelly], array[2,2]
    # if it goes beyond the total number of indices, it returns the max values for that range
    assert_equal [:and, :jelly], array[2,20]
    # This is out of range, but identifies the end of an array, without return nil or some error.
    # Probably intentional for algorithms
    assert_equal [], array[4,0]
    assert_equal [], array[4,100]
    assert_equal nil, array[5,0]
  end

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class
    # range, using ".." creates a range with all integers from 1-5
    assert_not_equal [1,2,3,4,5], (1..5)
    assert_equal [1, 2, 3, 4, 5], (1..5).to_a
    # creates a range from 1-4, so "..." includes all integers but the last
    assert_equal [1, 2, 3, 4], (1...5).to_a
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut,:butter,:and], array[0..2]
    assert_equal [:peanut,:butter], array[0...2]
    # this works as long as the negative indice doesn't start before the positive indice.
    assert_equal [:and, :jelly], array[2..-1]
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal [1,2, :last], array

    popped_value = array.pop
    assert_equal :last, popped_value
    assert_equal [1,2], array
  end

  def test_shifting_arrays
    array = [1,2]
    # unshift appends element to front of array and returns the new array
    array.unshift(:first)

    assert_equal [:first,1,2], array

    #shift removes element from front of an array and returns it
    shifted_value = array.shift
    assert_equal :first, shifted_value
    assert_equal [1,2], array
  end

end
