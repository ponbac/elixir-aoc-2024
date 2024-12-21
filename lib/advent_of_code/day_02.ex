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
    with true <- valid_differences?(list),
         true <- consistent_direction?(list) do
      true
    else
      _ -> false
    end
  end

  def valid_differences?([a, b | rest]) do
    diff = abs(a - b)
    diff >= 1 and diff <= 3 and valid_differences?([b | rest])
  end

  def valid_differences?(_) do
    true
  end

  def consistent_direction?([a, b | rest]) do
    increasing = &(&1 < &2)
    decreasing = &(&1 > &2)

    cond do
      increasing.(a, b) -> consistent_direction?([b | rest], increasing)
      decreasing.(a, b) -> consistent_direction?([b | rest], decreasing)
      true -> false
    end
  end

  def consistent_direction?([a, b | rest], comparison) do
    comparison.(a, b) and consistent_direction?([b | rest], comparison)
  end

  def consistent_direction?([_], _), do: true

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
  end
end
