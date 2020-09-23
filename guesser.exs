limit = IO.gets("Enter limit number: ")
{limit, _} = Integer.parse(limit)

random_number = :rand.uniform(limit)
{user_number, _} = Integer.parse(IO.gets("Guess the number: "))
^random_number = user_number
IO.puts("You was right! The number was: #{random_number}")
