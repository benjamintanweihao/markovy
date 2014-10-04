defmodule Markovy do
  defmodule Dictionary do
    def new do
      :random.seed(:os.timestamp)
      HashDict.new
    end

    def build(dict, text) when is_binary(text) do
      tokens = String.split(text)
      build(dict, tokens)
    end

    def build(dict, [prefix_1, prefix_2, suffix|rest]) do
      prefix   = "#{prefix_1} #{prefix_2}"
      new_dict = case HashDict.get(dict, prefix) do
        nil ->
          HashDict.put_new(dict, prefix, [suffix])
        suffixes ->
          HashDict.put_new(dict, prefix, [suffix|suffixes])
      end
      build(new_dict, [prefix_2, suffix|rest])
    end

    def build(dict, _source) do
      dict
    end
  end

  def next(dict, prefix) do
    HashDict.get(dict, prefix, []) |> Enum.shuffle |> List.first
  end

  def generate_sentence(dict, seed_prefix, max_length) when is_binary(seed_prefix) do
    [prefix_1, prefix_2] = String.split(seed_prefix)
    generate_sentence(dict, [prefix_2, prefix_1], 0, max_length)
  end

  def generate_sentence(_dict, result, max_length, max_length) do
    process_result(result)
  end

  def generate_sentence(dict, [prefix_2, prefix_1|rest] = list, current_length, max_length) do
    case next(dict, "#{prefix_1} #{prefix_2}") do
      nil  ->
        process_result(rest)
      next ->
        generate_sentence(dict, [next|list], current_length+1, max_length)
    end
  end

  def process_result(result) do
    result |> Enum.reverse |> Enum.join(" ")
  end

end

