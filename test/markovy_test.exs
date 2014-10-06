defmodule MarkovyTest do
  use ExUnit.Case

  # @source "you can't handle the law"
  @source File.read!("sample/sample.txt")
  @dictionary Markovy.Dictionary.new |> Markovy.Dictionary.build(@source)

  # test "building the dictionary" do
  #   # source = "of the people by the people for the people"
  #   # dictionary = Markovy.Dictionary.new |> Markovy.Dictionary.build(source)
  #   # assert dictionary["people"] == ["for", "by"]
  # end


  # test "generate the next word given a prefix" do
  #   # dict = Markovy.Dictionary.build(Markovy.Dictionary.new, @source)
  #   # assert dict |> Markovy.next("you")    == "can't"
  #   # assert dict |> Markovy.next("can't")  == "handle"
  #   # assert dict |> Markovy.next("handle") == "the"
  #   # assert dict |> Markovy.next("the")    == "law"
  # end

  test "generates a sentence given seed prefix and a word limit" do
    dict = Markovy.Dictionary.build(Markovy.Dictionary.new, @source)
    1..10 |> Enum.map(fn _ -> 
      IO.puts dict |> Markovy.generate_sentence("sexual", 40)
      IO.puts "===="
    end)
  end

end

