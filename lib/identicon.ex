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
  end

  defp hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
