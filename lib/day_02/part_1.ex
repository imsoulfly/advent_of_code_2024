defmodule Day02.Part1 do
  def solve do
    load_lists_from_file()
    |> count_safe_reports()
  end

  def load_lists_from_file do
    File.read!("./priv/static/puzzle_02_input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp count_safe_reports(reports) do
    Enum.reduce(reports, 0, fn report, acc ->
      if report_safe?(report) do
        IO.puts("Safe report: #{inspect(report, charlists: :as_lists)}")
        acc + 1
      else
        IO.puts("Unsafe report: #{inspect(report, charlists: :as_lists)}")
        acc
      end
    end)
  end

  defp report_safe?([first, second | report]) do
    if first > second do
      _report_safe?(first, [second | report], :desc)
    else
      _report_safe?(first, [second | report], :asc)
    end
  end

  defp _report_safe?(_, [], _), do: true

  defp _report_safe?(last, [next | report], :desc) do
    IO.puts("last: #{inspect(last, charlists: :as_lists)}, next: #{inspect(next, charlists: :as_lists)}")
    cond do
      last < next -> false
      (last - next) > 3 -> false
      (last - next) < 1 -> false
      true -> _report_safe?(next, report, :desc)
    end
  end

  defp _report_safe?(last, [next | report], :asc) do
    cond do
      next < last  -> false
      (next - last) > 3 -> false
      (next - last) < 1 -> false
      true -> _report_safe?(next, report, :asc)
    end
  end
end
