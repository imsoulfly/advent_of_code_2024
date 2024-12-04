defmodule Day03.Part2 do
  def solve do
    load_code_from_file()
    |> collect_correct_statements()
    |> calculation(:do, 0)
  end

  def load_code_from_file do
    File.read!("./priv/static/puzzle_03_input.txt")
  end

  def collect_correct_statements(statements) do
    Regex.scan(~r/(mul\((\d|\d\d|\d\d\d),(\d|\d\d|\d\d\d)\)|do\(\)|don't\(\))/, statements)
  end

  def calculation([], _, acc), do: acc
  def calculation([ ["do()", _] | rest], _, acc), do: calculation(rest, :do, acc)
  def calculation([ ["don't()", _] | rest], _, acc), do: calculation(rest, :dont, acc)
  def calculation([[_, _, _, _] | rest], :dont, acc), do: calculation(rest, :dont, acc)
  def calculation([[_, _, a, b] | rest], :do, acc) do
    acc = acc + (String.to_integer(a) * String.to_integer(b))
    calculation(rest, :do, acc)
  end
end
