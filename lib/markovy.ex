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

  def next(dict, prefix) do
    HashDict.get(dict, prefix, []) |> Enum.shuffle |> List.first
  end

  def generate_sentence(dict, seed_prefix, max_length) when is_binary(seed_prefix) do
    generate_sentence(dict, [seed_prefix], 0, max_length)
  end

  def generate_sentence(_dict, result, max_length, max_length) do
    process_result(result)
  end

  def generate_sentence(dict, [prefix|rest] = list, current_length, max_length) do
    case next(dict, prefix) do
      nil  ->
        process_result([prefix|rest])
      next ->
        generate_sentence(dict, [next|list], current_length+1, max_length)
    end
  end

  def process_result(result) do
    result |> Enum.reverse |> Enum.join(" ")
  end

end

