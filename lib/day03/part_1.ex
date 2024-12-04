defmodule Day03.Part1 do
  def solve do
    load_code_from_file()
    |> collect_correct_statements()
    |> Enum.reduce(0, fn statement, acc ->
      acc + calculate(statement)
    end)
  end

  def load_code_from_file do
    File.read!("./priv/static/puzzle_03_input.txt")
    # |> String.split("\n", trim: true)
    # |> Enum.map(fn line ->
    #   String.split(line, " ")
    #   |> Enum.map(&String.to_integer/1)
    # end)
  end

  def collect_correct_statements(statements) do
    Regex.scan(~r/mul\((\d|\d\d|\d\d\d),(\d|\d\d|\d\d\d)\)/, statements)
  end

  def calculate([_, a, b]) do
    String.to_integer(a) * String.to_integer(b)
  end
end
