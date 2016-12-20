require 'test_helper'

class DeepthoughTest < Minitest::Test

  def test_class
    foo = Deepthough::Deepthough.new
    assert_kind_of(Deepthough::Deepthough, foo, "")
  end

  def test_respond
    foo = Deepthough::Deepthough.new
    question = "The Ultimate Question of Life, the Universe and Everything"
    assert_equal(foo.respond(question), "42")
    question = "LOL"
    assert_equal(foo.respond(question), "Mmmm i'm bored")
  end

  def test_that_it_has_a_version_number
    refute_nil ::Deepthough::VERSION
  end
end
