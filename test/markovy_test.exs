defmodule MarkovyTest do
  use ExUnit.Case

  @source "the judge and the jury put the blame on me"
  @dictionary Markovy.Dictionary.new |> Markovy.Dictionary.build(@source)

  test "generate the next word given a prefix" do
    dict = Markovy.Dictionary.build(Markovy.Dictionary.new, @source)
    assert dict |> Markovy.next("the judge")    == "and"
    assert dict |> Markovy.next("judge and")    == "the"
    assert dict |> Markovy.next("and the")      == "jury"
    assert dict |> Markovy.next("the jury")     == "put"
    assert dict |> Markovy.next("jury put")     == "the"
    assert dict |> Markovy.next("put the")      == "blame"
    assert dict |> Markovy.next("the blame")    == "on"
    assert dict |> Markovy.next("blame on")     == "me"
  end

  test "generates a sentence given seed prefix and a word limit" do
    dict = Markovy.Dictionary.build(Markovy.Dictionary.new, @source)
    assert dict |> Markovy.generate_sentence("the judge", 8) == @source
  end

end

