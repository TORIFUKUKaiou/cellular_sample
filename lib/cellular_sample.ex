defmodule CellularSample do
  @moduledoc """
  Documentation for CellularSample.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CellularSample.hello
      :world

  """
  use Toolshed

  def hello do
    :world
  end

  def connect do
    cmd("mknod /dev/ppp c 108 0")
    cmd("pon soracom")
  end

  def update_route do
    cmd("ip rou delete default")
    cmd("ip rou add default via #{ip_address()} dev ppp0")
  end

  # ifconfigしてIP Addressを取得している感じです
  defp ip_address do
    {:ok, list} = :inet.getifaddrs()

    Enum.filter(list, fn {type, _} -> type == 'ppp0' end)
    |> Enum.at(0)
    |> elem(1)
    |> Enum.at(1)
    |> elem(1)
    |> Tuple.to_list()
    |> Enum.join(".")
  end
end
