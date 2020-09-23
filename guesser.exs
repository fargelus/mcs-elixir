{limit, _} = Integer.parse(IO.gets("Enter limit number: "))

random_number = :rand.uniform(limit)
{^random_number, _} = Integer.parse(IO.gets("Guess the number: "))

IO.puts("You was right! The number was: #{random_number}")
