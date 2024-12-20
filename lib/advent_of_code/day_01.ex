defmodule AdventOfCode.Day01 do
  def part1(input) do
    input
    |> parse_input()
    |> then(fn {left, right} ->
      Enum.zip(Enum.sort(left), Enum.sort(right))
    end)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse_input()
    |> then(fn {left, right} ->
      freq = Enum.frequencies(right)
      Enum.map(left, fn l -> l * (freq[l] || 0) end)
    end)
    |> Enum.sum()
  end

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> Enum.unzip()
  end
end
