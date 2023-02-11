input = 0..9999999999
input_length = Enum.count(input)

nodes = [Node.self() | Node.list()]
node_count = Enum.count(nodes)

piece_size = input_length |> Kernel./(node_count) |> Float.ceil |> trunc()
|> IO.inspect()

input
|> Stream.chunk_every(piece_size)
|> Stream.with_index()
|> Stream.map(fn {chunk, index} ->
  node = Enum.at(nodes, index)
  :erpc.call(node, Enum, :sum, chunk)
end)
|> Enum.to_list()
|> IO.inspect()
