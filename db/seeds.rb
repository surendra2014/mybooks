5.times do
	Book.create({

		title: Faker::Book.title,
		body: Faker::Book.author

	})
end