defmodule AdventOfCode.Day02 do
  def part1(input) do
    input
    |> parse_input()
    |> Enum.count(&is_valid?/1)
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.count(fn list -> is_valid?(list) or list_with_removals_valid?(list) end)
  end

  def list_with_removals_valid?(list) do
    0..(length(list) - 1)
    |> Enum.map(&List.delete_at(list, &1))
    |> Enum.any?(&is_valid?/1)
  end

  def is_valid?(list) do
    pairs = Enum.chunk_every(list, 2, 1, :discard)

    with true <- valid_differences?(pairs),
         true <- consistent_direction?(pairs) do
      true
    else
      _ -> false
    end
  end

  def valid_differences?(pairs) do
    Enum.all?(pairs, fn [a, b] ->
      diff = abs(a - b)
      diff >= 1 and diff <= 3
    end)
  end

  def consistent_direction?(pairs) do
    directions = Enum.map(pairs, fn [a, b] -> b > a end)
    Enum.all?(directions) or not Enum.any?(directions)
  end

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
  end
end
