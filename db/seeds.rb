require 'open-uri'

puts 'Cleaning database'

# Conversation.destroy_all
# Appointment.delete_all
# Message.destroy_all
# GiverGardenerPoint.destroy_all
# User.destroy_all


puts 'Cleaned database User, Appointment'


puts "Create 5 gardeners"

gardener_1 = User.new(
  first_name: "Alice", 
  last_name: "Alicette", 
  email: "alice@mail.com", 
  password: 'azerty',
  garden_name: "Chez Alice",
  description: "Nous cultivons des tomates et des abricots",
  address: '2 cours du Chapeau Rouge, Bordeaux',
  type: "Gardener",
  nb_of_points_for_a_gift: "20", 
  products: ["abricots", "bananes", "tomates"]
)
main_image = URI.open("https://images.unsplash.com/photo-1621496654772-c66c48290259?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y29tcG9zdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60")
gardener_1.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
gardener_1.save!

gardener_2 = User.new(
  first_name: "Bob", 
  last_name: "Bobby", 
  email: "bob@mail.com", 
  password: 'azerty',
  garden_name: "Bob le composteur",
  description: "Je cherche surtout du compost mûr pour mes pommes de terre",
  address: '3 place de la Victoire, Bordeaux',
  type: "Gardener",
  nb_of_points_for_a_gift: "10", 
  products: ["potirons", "kiwis", "choux-fleur"]
)
main_image = URI.open("https://images.unsplash.com/photo-1557296691-edb10ad8da28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y29tcG9zdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60")
gardener_2.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
gardener_2.save!

gardener_3 = User.new(
  first_name: "Charlie", 
  last_name: "Charls", 
  email: "charlie@mail.com", 
  password: 'azerty',
  garden_name: "Charlie le green",
  description: "Je suis fermé le weekend mais très flexible en semaine",
  address: '2 cours Alsace-Lorraine, Bordeaux',
  type: "Gardener",
  nb_of_points_for_a_gift: "9", 
  products: ["pommes de terres", "poires", "concombres"]
)
main_image = URI.open("https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
gardener_3.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
gardener_3.save!

gardener_4 = User.new(
  first_name: "David", 
  last_name: "Daviette", 
  email: "david@mail.com", 
  password: 'azerty',
  garden_name: "David le jardinier",
  description: "Je cherche du compost pour mes courgettes et mes laitues",
  address: '3 du Loup, Bordeaux',
  type: "Gardener",
  nb_of_points_for_a_gift: "30", 
  products: ["laitues", "asperges", "betteraves"]
)
main_image = URI.open("https://images.unsplash.com/photo-1536703219213-0223580c76b2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
gardener_4.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
gardener_4.save!

gardener_5 = User.new(
  first_name: "Emilie", 
  last_name: "Emielle", 
  email: "emilie@mail.com", 
  password: 'azerty',
  garden_name: "Le jardin d'Emilie",
  description: "Je cherche du compost mûr pour tomates et mes pommes",
  address: '22 rue Sainte Catherine, Bordeaux',
  type: "Gardener",
  nb_of_points_for_a_gift: "10", 
  products: ["chataignes", "champignons", "fraises"]
)
main_image = URI.open("https://plus.unsplash.com/premium_photo-1678371209978-8a88c13c7da9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
gardener_5.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
gardener_5.save!

puts "Created 5 gardens"

puts "Create 3 users"
  giver_1 = User.new(
    first_name: "Felix", 
    last_name: "Fell", 
    email: "felice@mail.com", 
    password: 'azerty',
    type: "Giver",
  )
  giver_1.save!

  giver_2 = User.new(
    first_name: "Greg", 
    last_name: "Group", 
    email: "greg@mail.com", 
    password: 'azerty',
    type: "Giver",
  )
  giver_2.save!

  giver_3 = User.new(
    first_name: "Henri", 
    last_name: "Herr", 
    email: "henri@mail.com", 
    password: 'azerty',
    type: "Giver",
  )
  giver_3.save!

puts "Created 3 users"

puts "Create 3 appointments"

  appointment_1 = Appointment.create(
    giver_id: giver_1.id,
    gardener_id: gardener_1.id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today
  )

  appointment_2 = Appointment.create(
    giver_id: giver_1.id,
    gardener_id: gardener_2.id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today
  )

  appointment_3 = Appointment.create(
    giver_id: giver_1.id,
    gardener_id: gardener_3.id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.yesterday
  )

  appointment_4 = Appointment.create(
    giver_id: giver_1.id,
    gardener_id: gardener_1.id, 
    quantity: 3, 
    compost_type: "compost mûr",
    date: Date.yesterday - 3, 
    status: "confirmed"
  )

  appointment_5 = Appointment.new(
    giver_id: giver_1.id,
    gardener_id: gardener_1.id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today, 
    status: "confirmed"
  )

  appointment_5 = Appointment.create(
    giver_id: giver_1.id,
    gardener_id: gardener_3.id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today + 3
  )

  appointment_6 = Appointment.create(
    giver_id: giver_1.id,
    gardener_id: gardener_3.id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today + 5
  )

# Create Giver Gardner Points

givers_gardeners_points_1 = GiverGardenerPoint.create(
  giver_id: giver_1.id,
  gardener_id: gardener_1.id,
  nb_of_points: 3
)

givers_gardeners_points_2 = GiverGardenerPoint.create(
  giver_id: giver_1.id,
  gardener_id: gardener_1.id,
  nb_of_points: 3
)

givers_gardeners_points_3 = GiverGardenerPoint.create(
  giver_id: giver_1.id,
  gardener_id: gardener_2.id,
  nb_of_points: 5
)

givers_gardeners_points_4 = GiverGardenerPoint.create(
  giver_id: giver_2.id,
  gardener_id: gardener_2.id,
  nb_of_points: 2
)

givers_gardeners_points_5 = GiverGardenerPoint.create(
  giver_id: giver_1.id,
  gardener_id: gardener_3.id,
  nb_of_points: 1
)

givers_gardeners_points_6 = GiverGardenerPoint.create(
  giver_id: giver_1.id,
  gardener_id: gardener_3.id,
  nb_of_points: 8
)

givers_gardeners_points_7 = GiverGardenerPoint.create(
  giver_id: giver_1.id,
  gardener_id: gardener_1.id,
  nb_of_points: 14
)