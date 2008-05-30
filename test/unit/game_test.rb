require File.dirname(__FILE__) + '/../test_helper'

class GameTest < ActiveSupport::TestCase
  def test_should_create_game_with_good_values
    g = Game.create(:talon => (0..80).to_a)
    assert_equal 81, g.talon.size
    assert_equal 12, g.tapis.size
    assert_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], g.tapis
    assert_equal 13, g.get_sets.size
    assert_equal 12, g.courante
    assert_equal 0, g.etendu
    assert_equal 0, g.nb_set
    assert_equal 0, g.nb_bad_set
    assert_equal 0, g.nb_point
  end

  def test_should_extend_game
    g = Game.create(:talon => [41, 60, 9, 7, 4, 55, 63, 62, 40, 28, 6, 79, 0, 78, 8, 70, 72, 18, 15, 71, 44, 52, 1, 21, 45, 46, 73, 80, 65, 2, 68, 74, 32, 19, 33, 75, 25, 11, 39, 69, 3, 43, 17, 27, 42, 76, 29, 12, 58, 53, 50, 34, 38, 61, 26, 36, 49, 16, 30, 22, 48, 24, 23, 57, 66, 47, 56, 54, 13, 31, 5, 37, 51, 35, 10, 14, 59, 77, 67, 20, 64])
    assert_equal 15, g.tapis.size
    assert_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], g.tapis
    assert_equal 15, g.courante
    assert_equal 1, g.etendu
    assert_equal 0, g.nb_set
    assert_equal 0, g.nb_bad_set
    assert_equal 0, g.nb_point
  end

  def test_should_double_extend_game
    g = Game.create(:talon => [77, 27, 9, 1, 15, 31, 19, 48, 46, 8, 68, 26, 50, 76, 79, 66, 25, 41, 75, 4, 23, 36, 80, 74, 24, 30, 17, 57, 59, 16, 73, 53, 37, 72, 5, 61, 32, 20, 28, 63, 38, 34, 44, 62, 22, 18, 12, 70, 10, 52, 43, 67, 11, 21, 39, 35, 33, 3, 78, 13, 60, 54, 14, 0, 56, 55, 58, 69, 29, 71, 6, 2, 45, 42, 65, 7, 40, 64, 49, 47, 51])
    assert_equal 18, g.tapis.size
    assert_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17], g.tapis
    assert_equal 18, g.courante
    assert_equal 2, g.etendu
    assert_equal 0, g.nb_set
    assert_equal 0, g.nb_bad_set
    assert_equal 0, g.nb_point
  end

  def test_should_find_set_ideal
    g = Game.create(:talon => (0..80).to_a)
    assert_equal true, g.try_set([0, 1, 2])
    assert_equal [12, 13, 14, 3, 4, 5, 6, 7, 8, 9, 10, 11], g.tapis
    assert_equal 15, g.courante
    assert_equal 1, g.nb_set
    assert_equal 0, g.nb_bad_set
    assert_equal 1, g.nb_point
  end

  def test_should_not_find_non_set_ideal
    g = Game.create(:talon => (0..80).to_a)
    assert_equal false, g.try_set([0, 1, 3])
    assert_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], g.tapis
    assert_equal 12, g.courante
    assert_equal 0, g.nb_set
    assert_equal 1, g.nb_bad_set
    assert_equal(-13, g.nb_point)
  end

  def test_should_find_set_extended
    g = Game.create(:talon => [41, 60, 9, 7, 4, 55, 63, 62, 40, 28, 6, 79, 0, 78, 8, 70, 72, 18, 15, 71, 44, 52, 1, 21, 45, 46, 73, 80, 65, 2, 68, 74, 32, 19, 33, 75, 25, 11, 39, 69, 3, 43, 17, 27, 42, 76, 29, 12, 58, 53, 50, 34, 38, 61, 26, 36, 49, 16, 30, 22, 48, 24, 23, 57, 66, 47, 56, 54, 13, 31, 5, 37, 51, 35, 10, 14, 59, 77, 67, 20, 64])
    assert_equal true, g.try_set([0, 11, 12])
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14], g.tapis
    assert_equal 15, g.courante
    assert_equal 0, g.etendu
    assert_equal 1, g.nb_set
    assert_equal 0, g.nb_bad_set
    assert_equal 4, g.nb_point
  end

  def test_should_not_find_non_set_extended
    g = Game.create(:talon => [41, 60, 9, 7, 4, 55, 63, 62, 40, 28, 6, 79, 0, 78, 8, 70, 72, 18, 15, 71, 44, 52, 1, 21, 45, 46, 73, 80, 65, 2, 68, 74, 32, 19, 33, 75, 25, 11, 39, 69, 3, 43, 17, 27, 42, 76, 29, 12, 58, 53, 50, 34, 38, 61, 26, 36, 49, 16, 30, 22, 48, 24, 23, 57, 66, 47, 56, 54, 13, 31, 5, 37, 51, 35, 10, 14, 59, 77, 67, 20, 64])
    assert_equal false, g.try_set([0, 1, 2])
    assert_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], g.tapis
    assert_equal 15, g.courante
    assert_equal 1, g.etendu
    assert_equal 0, g.nb_set
    assert_equal 1, g.nb_bad_set
    assert_equal(-3, g.nb_point)
  end

  def test_should_find_set_double_extended
    g = Game.create(:talon => [77, 27, 9, 1, 15, 31, 19, 48, 46, 8, 68, 26, 50, 76, 79, 66, 25, 41, 75, 4, 23, 36, 80, 74, 24, 30, 17, 57, 59, 16, 73, 53, 37, 72, 5, 61, 32, 20, 28, 63, 38, 34, 44, 62, 22, 18, 12, 70, 10, 52, 43, 67, 11, 21, 39, 35, 33, 3, 78, 13, 60, 54, 14, 0, 56, 55, 58, 69, 29, 71, 6, 2, 45, 42, 65, 7, 40, 64, 49, 47, 51])
    assert_equal true, g.try_set([1, 10, 16])
    assert_equal [0, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 17], g.tapis
    assert_equal 18, g.courante
    assert_equal 1, g.etendu
    assert_equal 1, g.nb_set
    assert_equal 0, g.nb_bad_set
    assert_equal 4, g.nb_point
  end

  def test_should_not_find_non_set_double_extended
    g = Game.create(:talon => [77, 27, 9, 1, 15, 31, 19, 48, 46, 8, 68, 26, 50, 76, 79, 66, 25, 41, 75, 4, 23, 36, 80, 74, 24, 30, 17, 57, 59, 16, 73, 53, 37, 72, 5, 61, 32, 20, 28, 63, 38, 34, 44, 62, 22, 18, 12, 70, 10, 52, 43, 67, 11, 21, 39, 35, 33, 3, 78, 13, 60, 54, 14, 0, 56, 55, 58, 69, 29, 71, 6, 2, 45, 42, 65, 7, 40, 64, 49, 47, 51])
    assert_equal false, g.try_set([0, 1, 2])
    assert_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17], g.tapis
    assert_equal 18, g.courante
    assert_equal 2, g.etendu
    assert_equal 0, g.nb_set
    assert_equal 1, g.nb_bad_set
    assert_equal(-5, g.nb_point)
  end

  def test_should_play_all_cards_in_game
    g = Game.create(:talon => (0..80).to_a)
    27.times do
      assert_equal true, g.try_set(g.get_sets[0])
    end
    assert_equal 0, g.tapis.size
    assert_equal 81, g.courante
    assert_equal(-4, g.etendu)
    assert_equal 27, g.nb_set
    assert_equal 0, g.nb_bad_set
    assert_equal 27, g.nb_point
  end
end
