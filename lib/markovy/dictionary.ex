defmodule Markovy.Dictionary do

  def new do
    :random.seed(:os.timestamp)
    HashDict.new
  end

  def build(dict, text) when is_binary(text) do
    tokens = String.split(text)
    build(dict, tokens)
  end

  def build(dict, [prefix, suffix|rest]) do
    new_dict = case HashDict.get(dict, prefix) do
      nil ->
        HashDict.put(dict, prefix, [suffix])
      suffixes ->
        HashDict.put(dict, prefix, [suffix|suffixes])
    end
    build(new_dict, [suffix|rest])
  end

  def build(dict, _source) do
    dict
  end

end
