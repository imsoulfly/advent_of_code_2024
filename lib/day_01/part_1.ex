defmodule Day01.Part1 do
  def solve do
    load_lists_from_file()
    |> sort()
    |> sum_of_distances(0)
  end

  def load_lists_from_file do
    File.read!("./priv/static/puzzle_01_input.txt")
    |> String.split("\n", trim: true)
    |> Enum.reduce({[],[]}, fn line, {left, right} ->
      [l, r] = String.split(line, "   " )
      {[String.to_integer(l) | left], [String.to_integer(r) | right]}
    end)
  end

  def sum_of_distances({[l | []], [r | []]}, d) do
    d + distance(l, r)
  end

  def sum_of_distances({[l | left], [r | right]}, d) do
    sum_of_distances({left, right}, d + distance(l, r))
  end

  defp distance(l, r) when l > r, do: l - r
  # catch all for when l <= r
  defp distance(l, r), do: r - l

  defp sort({left, right}) do
    {Enum.sort(left), Enum.sort(right)}
  end
end
