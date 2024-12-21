defmodule AdventOfCode.Day04 do
  def part1(input) do
    grid = parse_input(input)
    dimensions = {length(grid), length(Enum.at(grid, 0))}

    for row <- 0..(elem(dimensions, 0) - 1),
        col <- 0..(elem(dimensions, 1) - 1),
        direction <- directions() ++ diagonal_directions(),
        reduce: 0 do
      acc -> acc + if xmas_at_position?(grid, {row, col}, direction, dimensions), do: 1, else: 0
    end
  end

  def part2(input) do
    grid = parse_input(input)
    dimensions = {length(grid), length(Enum.at(grid, 0))}

    for row <- 0..(elem(dimensions, 0) - 1),
        col <- 0..(elem(dimensions, 1) - 1),
        reduce: 0 do
      acc -> acc + if mas_cross_at_position?(grid, {row, col}, dimensions), do: 1, else: 0
    end
  end

  defp xmas_at_position?(grid, start_pos, direction, {height, width}) do
    0..3
    |> Enum.map(&position_at(start_pos, direction, &1))
    |> Enum.all?(&in_bounds?(&1, height, width))
    and get_word_with_length(grid, start_pos, direction, 4) == "XMAS"
  end

  defp mas_cross_at_position?(grid, {row, col}, {height, width}) do
    positions = [
      {row-1, col-1}, {row-1, col+1},  # top left, top right
      {row+1, col-1}, {row+1, col+1}   # bottom left, bottom right
    ]

    with "A" <- grid |> Enum.at(row) |> Enum.at(col),
         true <- Enum.all?(positions, &in_bounds?(&1, height, width)),
         [tl, tr, bl, br] <- Enum.map(positions, fn {r, c} -> grid |> Enum.at(r) |> Enum.at(c) end) do
      is_mas?(tl <> "A" <> br) and is_mas?(tr <> "A" <> bl)
    else
      _ -> false
    end
  end

  defp is_mas?(word) do
    word == "MAS" or word == "SAM"
  end

  defp get_word_with_length(grid, {row, col}, {dy, dx}, length) do
    0..(length - 1)
    |> Enum.map(fn i ->
      grid
      |> Enum.at(row + (i * dy))
      |> Enum.at(col + (i * dx))
    end)
    |> Enum.join()
  end

  defp position_at({row, col}, {dy, dx}, offset) do
    {row + (offset * dy), col + (offset * dx)}
  end

  defp in_bounds?({row, col}, height, width) do
    row >= 0 and row < height and col >= 0 and col < width
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  defp directions do
    [
      {0, 1},    # right
      {1, 0},    # down
      {0, -1},   # left
      {-1, 0},   # up
    ]
  end

  defp diagonal_directions do
    [
      {1, 1},    # down-right
      {1, -1},   # down-left
      {-1, 1},   # up-right
      {-1, -1}   # up-left
    ]
  end
end
