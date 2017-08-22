defmodule Identicon do
  @moduledoc """
    Generate an unique avatar for an input.
  """

  @doc """
    Calls every needed methods to generate an image from a input.
  """
  def main(input) do
    input
    |> hash_input(input)
  end

  defp hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end
end
