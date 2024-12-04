defmodule Day02.Part2 do
  def solve do
    Day02.Part1.load_lists_from_file()
    |> count_safe_reports()
  end

  defp count_safe_reports(reports) do

    Enum.reduce(reports, 0, fn report, acc ->
      case safeish?(report) do
        true ->
          IO.puts("Safe report: #{inspect(report, charlists: :as_lists)}")
          acc + 1
        false ->
          IO.puts("Unsafe report: #{inspect(report, charlists: :as_lists)}")
          acc
      end
    end)
  end

  defp safeish?(report) do
    dampened_reports =
      0..(length(report)-1)
      |> Enum.map(&List.delete_at(report, &1))

    Enum.any?([report | dampened_reports], &check_for_safety?/1)
  end

  def check_for_safety?([a, b | _] = report) do
    direction = if b - a > 0, do: 1, else: -1
    _check_for_safety?(report, direction)
  end
  def _check_for_safety?([_], _), do: true
  def _check_for_safety?([a, b | rest], direction) do
    ((b - a) * direction) in 1..3 && _check_for_safety?([b | rest], direction)
  end
end
