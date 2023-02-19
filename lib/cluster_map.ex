defmodule ClusterMap do
  def sum_clustered(values, num_nodes) do
    chunk_size = div(length(values), num_nodes)

    chunks_and_nodes = create_chunks_and_nodes(values, chunk_size, num_nodes)

    nodes = start_nodes(chunks_and_nodes)

    results = collect_results(nodes)

    Enum.sum(results)
  end

  def create_chunks_and_nodes(values, chunk_size, num_nodes) do
    for n <- 1..num_nodes do
      chunk = Enum.slice(values, (n - 1) * chunk_size, chunk_size)

      node = spawn_node()

      {chunk, node}
    end
  end

  defp spawn_node do
    node_name = :"node#{:rand.uniform(1_000_000_000)}"

    Node.spawn(node_name, &node_loop/0)

    node_name
  end

  defp node_loop do
    receive do
      {:process_chunk, chunk} ->
        sum = Enum.sum(chunk)

        send(self(), {:sum_result, sum})

        node_loop()
    end
  end

  defp start_nodes(chunks_and_nodes) do
    Enum.map(chunks_and_nodes, fn {chunk, node} ->
      send(node, {:process_chunk, chunk})

      node
    end)
  end

  defp collect_results(nodes) do
    Enum.map(nodes, fn node ->
      receive do
        {:sum_result, sum} ->
          sum
      end
    end)
  end
end
