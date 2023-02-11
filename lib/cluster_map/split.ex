defmodule ClusterMap.Split do
  def chunk([] = l, _n) do
    l
  end

  def chunk(list, n) when is_list(list) do
    chunk(Enum.split(list, n), n)
  end

  def chunk({l, t}, n) when length(t) <  n * 2 do
    [l | [t]]
  end

  def chunk({l, t}, n) do
    [l | chunk(t, n)]
  end
end
