require 'open-uri'

puts 'Cleaning database'

# Conversation.destroy_all
# Appointment.delete_all
# Message.destroy_all
# GiverGardenPoint.destroy_all
# User.destroy_all


puts 'Cleaned database User, Appointment'

puts "Create 7 users"

  user_1 = User.new(
    first_name: "Alice", 
    last_name: "Alicette", 
    email: "alice@mail.com", 
    password: 'azerty')
  user_1.save!

  user_2 = User.new(
    first_name: "Bob", 
    last_name: "Bobby", 
    email: "bob@mail.com", 
    password: 'azerty')
  user_2.save!

  user_3 = User.new(
    first_name: "Charlie", 
    last_name: "Charls", 
    email: "charlie@mail.com", 
    password: 'azerty')
  user_3.save!

  user_4 = User.new(
    first_name: "David", 
    last_name: "Daviette", 
    email: "david@mail.com", 
    password: 'azerty',
  )
  user_4.save!

  user_5 = User.new(
    first_name: "Emilie", 
    last_name: "Emielle", 
    email: "emilie@mail.com", 
    password: 'azerty',
  )
  user_5.save!

  user_6 = User.new(
    first_name: "Felix", 
    last_name: "Fell", 
    email: "felix@mail.com", 
    password: 'azerty'
  )
  user_6.save!

  user_7 = User.new(
    first_name: "Greg", 
    last_name: "Group", 
    email: "greg@mail.com", 
    password: 'azerty'
  )
  user_7.save!

puts "Created 7 users"

puts "Create 5 gardens"

garden_1 = Garden.new(
  gardener_id: user_1.id,
  garden_name: "Chez Alice",
  description: "Nous cultivons des tomates et des abricots",
  address: '2 cours du Chapeau Rouge, Bordeaux',
  nb_of_points_for_a_gift: "20", 
  products: ["abricots", "bananes", "tomates"]
)
main_image = URI.open("https://images.unsplash.com/photo-1621496654772-c66c48290259?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y29tcG9zdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60")
garden_1.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_1.save!

garden_2 = Garden.new(
  gardener_id: user_2.id,
  garden_name: "Bob le composteur",
  description: "Je cherche surtout du compost mûr pour mes pommes de terre",
  address: '3 place de la Victoire, Bordeaux',
  nb_of_points_for_a_gift: "10", 
  products: ["potirons", "kiwis", "choux-fleur"]
)
main_image = URI.open("https://images.unsplash.com/photo-1557296691-edb10ad8da28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y29tcG9zdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60")
garden_2.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_2.save!

garden_3 = Garden.new(
  gardener_id: user_3.id,
  garden_name: "Charlie le green",
  description: "Je suis fermé le weekend mais très flexible en semaine",
  address: '2 cours Alsace-Lorraine, Bordeaux',
  nb_of_points_for_a_gift: "9", 
  products: ["pommes de terres", "poires", "concombres"]
)
main_image = URI.open("https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
garden_3.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_3.save!

garden_4 = Garden.new(
  gardener_id: user_4.id,
  garden_name: "David le jardinier",
  description: "Je cherche du compost pour mes courgettes et mes laitues",
  address: '3 du Loup, Bordeaux',
  nb_of_points_for_a_gift: "30", 
  products: ["laitues", "asperges", "betteraves"]
)
main_image = URI.open("https://images.unsplash.com/photo-1536703219213-0223580c76b2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
garden_4.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_4.save!

garden_5 = Garden.new(
  gardener_id: user_5.id,
  garden_name: "Le jardin d'Emilie",
  description: "Je cherche du compost mûr pour tomates et mes pommes",
  address: '22 rue Sainte Catherine, Bordeaux',
  nb_of_points_for_a_gift: "10", 
  products: ["chataignes", "champignons", "fraises"]
)
main_image = URI.open("https://plus.unsplash.com/premium_photo-1678371209978-8a88c13c7da9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
garden_5.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_5.save!

puts "Created 5 gardens"

puts "Create 3 appointments"

  appointment_1 = Appointment.create(
    giver_id: user_6.id,
    gardener_id: garden_1.gardener_id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today
  )

  appointment_2 = Appointment.create(
    giver_id: user_6.id,
    gardener_id: garden_2.gardener_id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today
  )

  appointment_3 = Appointment.create(
    giver_id: user_6.id,
    gardener_id: garden_3.gardener_id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.yesterday
  )

  appointment_4 = Appointment.create(
    giver_id: user_6.id,
    gardener_id: garden_4.gardener_id, 
    quantity: 3, 
    compost_type: "compost mûr",
    date: Date.yesterday - 3, 
    status: "confirmed"
  )

  appointment_5 = Appointment.new(
    giver_id: user_6.id,
    gardener_id: garden_1.gardener_id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today, 
    status: "confirmed"
  )

  appointment_5 = Appointment.create(
    giver_id: user_6.id,
    gardener_id: garden_1.gardener_id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today + 3
  )

  appointment_6 = Appointment.create(
    giver_id: user_7.id,
    gardener_id: garden_1.gardener_id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today + 5
  )

# Create Giver Gardener Points

givers_gardeners_points_1 = GiverGardenPoint.create(
  giver_id: user_6.id,
  garden_id: garden_1.id,
  nb_of_points: 3
)

givers_gardeners_points_2 = GiverGardenPoint.create(
  giver_id: user_6.id,
  garden_id: garden_1.id,
  nb_of_points: 17
)

givers_gardeners_points_3 = GiverGardenPoint.create(
  giver_id: user_6.id,
  garden_id: garden_2.id,
  nb_of_points: 10
)

givers_gardeners_points_4 = GiverGardenPoint.create(
  giver_id: user_7.id,
  garden_id: garden_1.id,
  nb_of_points: 2
)

givers_gardeners_points_5 = GiverGardenPoint.create(
  giver_id: user_6.id,
  garden_id: garden_3.id,
  nb_of_points: 1
)

givers_gardeners_points_6 = GiverGardenPoint.create(
  giver_id: user_6.id,
  garden_id: garden_4.id,
  nb_of_points: 8
)

givers_gardeners_points_7 = GiverGardenPoint.create(
  giver_id: user_1.id,
  garden_id: garden_1.id,
  nb_of_points: 14
)

# Create 7 conversations

conversation_1 = Conversation.create(
  appointment_id: appointment_1
)

conversation_2 = Conversation.create(
  appointment_id: appointment_2
)

conversation_3 = Conversation.create(
  appointment_id: appointment_3
)

conversation_4 = Conversation.create(
  appointment_id: appointment_4
)

conversation_5 = Conversation.create(
  appointment_id: appointment_5
)

conversation_6 = Conversation.create(
  appointment_id: appointment_6
)