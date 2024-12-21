defmodule AdventOfCode.Day04 do
  def part1(input) do
    grid = parse_input(input)
    height = length(grid)
    width = length(Enum.at(grid, 0))

    for row <- 0..(height - 1),
        col <- 0..(width - 1),
        direction <- directions(),
        reduce: 0 do
      acc ->
        if check_xmas(grid, {row, col}, direction, width, height) do
          acc + 1
        else
          acc
        end
    end
  end

  def part2(_args) do
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  defp directions do
    [
      {0, 1},   # right
      {1, 0},   # down
      {0, -1},  # left
      {-1, 0},  # up
      {1, 1},   # down-right
      {1, -1},  # down-left
      {-1, 1},  # up-right
      {-1, -1}  # up-left
    ]
  end

  defp check_xmas(grid, {row, col}, {dy, dx}, width, height) do
    positions = for i <- 0..3 do
      {row + (i * dy), col + (i * dx)}
    end

    if Enum.all?(positions, fn {r, c} ->
      r >= 0 and r < height and c >= 0 and c < width
    end) do
      letters = positions
      |> Enum.map(fn {r, c} ->
        grid |> Enum.at(r) |> Enum.at(c)
      end)
      |> Enum.join()

      letters == "XMAS"
    else
      false
    end
  end
end
