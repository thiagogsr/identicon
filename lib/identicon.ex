defmodule Identicon do
  @moduledoc """
    Generate an unique avatar for an input.
  """

  @doc """
    Calls every needed methods to generate an image from a input.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
  end

  defp build_pixel_map(%Identicon.Image{grid: grid} = image) do
    square_size = 50

    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * square_size
      vertical = div(index, 5) * square_size
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + square_size, vertical + square_size}
      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  defp filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  defp build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  defp mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  defp pick_color(%Identicon.Image{hex: [red, green, blue | _tail]} = image) do
    %Identicon.Image{image | color: {red, green, blue}}
  end

  defp hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
