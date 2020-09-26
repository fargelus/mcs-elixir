compute = fn(n, d) ->
  n / d
end

compute.(6, 3) |> IO.puts

print = fn ->
  IO.puts "Some string"
end

print.()
