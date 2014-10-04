defmodule Markovy.Dictionary do
  def start_link do
    Agent.start_link(fn -> new end)
  end

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
    Agent.update(__MODULE__, fn _ -> dict end)
  end

end
