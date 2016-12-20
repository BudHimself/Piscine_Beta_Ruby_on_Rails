require 'test_helper'

class Ft_WikipediaTest < Minitest::Test

  def test_42
    foo = Ft_Wikipedia::Ft_Wikipedia.new
    foo.search("42")
  end

  def test_class
    foo = Ft_Wikipedia::Ft_Wikipedia.new
    assert_kind_of(Ft_Wikipedia::Ft_Wikipedia, foo, "")
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ft_Wikipedia::VERSION
  end

end
