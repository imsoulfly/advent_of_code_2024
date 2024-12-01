defmodule Puzzle01Part2 do
  def solve do
    {left, right} = Puzzle01Part1.load_lists_from_file()

    groups_right = counted_groups(right)
    similarity_score(left, groups_right)
  end

  defp counted_groups(right), do: _counted_groups(right, %{})

  defp _counted_groups([], groups), do: groups
  defp _counted_groups([r | right], groups) do
    _counted_groups(right, Map.update(groups, r, 1, &(&1 + 1)))
  end

  def similarity_score(left, groups), do: _similarity_score(left, groups, 0)

  def _similarity_score([], _groups, score), do: score
  def _similarity_score([l | left], groups, score) do
    case Map.get(groups, l) do
      nil -> _similarity_score(left, groups, score)
      count -> _similarity_score(left, groups, score + (l * count))
    end
  end
end
