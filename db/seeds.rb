require 'open-uri'

puts 'Cleaning database'

puts 'Cleaned database User, Appointment'

puts "Create Admin User"
admin = User.new(
  first_name: "Admin", 
  last_name: "Administrator", 
  email: "admin@mail.com", 
  password: 'azerty', 
  admin: true
)
admin.save!

puts "Create 9 users"

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

user_8 = User.new(
  first_name: "Henri", 
  last_name: "Herr", 
  email: "henri@mail.com", 
  password: 'azerty'
)
user_8.save!

user_9 = User.new(
  first_name: "Isabelle", 
  last_name: "Iss", 
  email: "isabelle@mail.com", 
  password: 'azerty'
)
user_9.save!

puts "Create 5 gardens"

garden_2 = Garden.new(
  gardener_id: user_2.id,
  garden_name: "Le potager de Bob",
  description: "Un projet associatif mené par les 'Amis de Bob', pour une végétalisation des bureaux",
  address: '3 place de la Victoire, 33000 Bordeaux',
  nb_of_points_for_a_gift: "10", 
  products: ["potirons", "kiwis", "choux-fleur"]
)
main_image = URI.open("https://images.unsplash.com/photo-1557296691-edb10ad8da28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y29tcG9zdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60")
garden_2.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_2.save!

garden_3 = Garden.new(
  gardener_id: user_3.id,
  garden_name: "Le verger de Charlie",
  description: "Un espace collaboratif au service du bien-être et de la nature, en plein coeur du centre-ville",
  address: '2 cours Alsace-Lorraine, 33000 Bordeaux',
  nb_of_points_for_a_gift: "9", 
  products: ["pommes de terres", "poires", "concombres"]
)
main_image = URI.open("https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
garden_3.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_3.save!

garden_4 = Garden.new(
  gardener_id: user_4.id,
  garden_name: "David le jardinier",
  description: "Au coeur de l'éco-quartier rénové en 2017, avec 3 ruches, 2 potagers et 3 vergers",
  address: '3 du Loup, 33 000 Bordeaux',
  nb_of_points_for_a_gift: "30", 
  products: ["laitues", "asperges", "betteraves"]
)
main_image = URI.open("https://images.unsplash.com/photo-1536703219213-0223580c76b2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
garden_4.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_4.save!

garden_5 = Garden.new(
  gardener_id: user_5.id,
  garden_name: "Le jardin d'Emilie",
  description: "Une friche en permaculture entièrement rénovée, dans une ancienne gare ferrovière. A découvrir sans tarder !",
  address: '22 rue Sainte Catherine, 33000 Bordeaux',
  nb_of_points_for_a_gift: "10", 
  products: ["chataignes", "champignons", "fraises"]
)
main_image = URI.open("https://plus.unsplash.com/premium_photo-1678371209978-8a88c13c7da9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
garden_5.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_5.save!

garden_6 = Garden.new(
  gardener_id: user_8.id,
  garden_name: "Chez Henri",
  description: "Un restaurant avec des salariés en réinsertion professionnelle, avec une cuisine bio, locale et de saison, au coeur d'un grand jardin.",
  address: '22 rue Sainte Catherine, 33000 Bordeaux',
  nb_of_points_for_a_gift: "10", 
  products: ["chataignes", "champignons", "fraises"]
)
main_image = URI.open("https://plus.unsplash.com/premium_photo-1678371209978-8a88c13c7da9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGNvbXBvc3R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60")
garden_6.main_image.attach(io: main_image, filename: 'main_image.jpeg', content_type: 'image/png')
garden_6.save!

puts "Create Appointments for Alice (Giver)"

  appointment_1 = Appointment.create(
    giver_id: user_1.id,
    gardener_id: garden_2.gardener_id, 
    quantity: 2, 
    compost_type: "compost mûr",
    date: Date.today - 10, 
    status: "confirmed"
  )

  appointment_2 = Appointment.create(
    giver_id: user_1.id,
    gardener_id: garden_3.gardener_id, 
    quantity: 3, 
    compost_type: "compost mûr",
    date: Date.today - 7, 
    status: "confirmed"
  )

  appointment_3 = Appointment.create(
    giver_id: user_1.id,
    gardener_id: garden_4.gardener_id, 
    quantity: 5, 
    compost_type: "biodéchets",
    date: Date.today - 5, 
    status: "confirmed"
  )

  appointment_4 = Appointment.create(
    giver_id: user_1.id,
    gardener_id: garden_5.gardener_id, 
    quantity: 1, 
    compost_type: "biodéchets",
    date: Date.today - 2, 
    status: "pending"
  )

  appointment_5 = Appointment.create(
    giver_id: user_1.id,
    gardener_id: garden_2.gardener_id, 
    quantity: 1, 
    compost_type: "biodéchets",
    date: Date.yesterday, 
    status: "pending"
  )

  appointment_6 = Appointment.create(
    giver_id: user_1.id,
    gardener_id: garden_3.gardener_id, 
    quantity: 5, 
    compost_type: "compost mûr",
    date: Date.today + 3
  )

  appointment_7 = Appointment.create(
    giver_id: user_1.id,
    gardener_id: garden_3.gardener_id, 
    quantity: 1, 
    compost_type: "biodéchets",
    date: Date.today + 5
  )

puts "Create Appointments for Le Potager de Bob (Garden)"



  appointment_8 = Appointment.create(
    giver_id: user_4.id,
    gardener_id: garden_2.gardener_id, 
    quantity: 10, 
    compost_type: "biodéchets",
    date: Date.today - 2
  )

  appointment_9 = Appointment.create(
    giver_id: user_5.id,
    gardener_id: garden_2.gardener_id, 
    quantity: 3, 
    compost_type: "biodéchets",
    date: Date.today - 1
  )

  appointment_10 = Appointment.create(
    giver_id: user_6.id,
    gardener_id: garden_2.gardener_id, 
    quantity: 2, 
    compost_type: "biodéchets",
    date: Date.today + 3
  )

  appointment_11 = Appointment.create(
    giver_id: user_7.id,
    gardener_id: garden_2.gardener_id, 
    quantity: 1, 
    compost_type: "compost mûr",
    date: Date.today + 5
  )

# Create Giver Gardener Points

givers_gardeners_points_1 = GiverGardenPoint.create(
  giver_id: user_1.id,
  garden_id: garden_2.id,
  nb_of_points: 3
)

givers_gardeners_points_2 = GiverGardenPoint.create(
  giver_id: user_1.id,
  garden_id: garden_2.id,
  nb_of_points: 17
)

givers_gardeners_points_3 = GiverGardenPoint.create(
  giver_id: user_3.id,
  garden_id: garden_2.id,
  nb_of_points: 10
)

givers_gardeners_points_4 = GiverGardenPoint.create(
  giver_id: user_4.id,
  garden_id: garden_2.id,
  nb_of_points: 2
)

givers_gardeners_points_4 = GiverGardenPoint.create(
  giver_id: user_5.id,
  garden_id: garden_2.id,
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

puts "Create Rewards for Alice (Giver)"

Reward.create(
  gardener_id: 3,
  giver_id: 2, 
  used: true
)

Reward.create(
  gardener_id: 3,
  giver_id: 2, 
  used: true
)

Reward.create(
  gardener_id: 3,
  giver_id: 2, 
  used: false
)

Reward.create(
  gardener_id: 4,
  giver_id: 2, 
  used: true
)

Reward.create(
  gardener_id: 5,
  giver_id: 2, 
  used: false
)

Reward.create(
  gardener_id: 5,
  giver_id: 2, 
  used: true
)

puts "Create Rewards for Le Potager de Bob (Garden)"

Reward.create(
  gardener_id: 3,
  giver_id: 4, 
  used: true
)

Reward.create(
  gardener_id: 3,
  giver_id: 4, 
  used: false
)

Reward.create(
  gardener_id: 3,
  giver_id: 5, 
  used: true
)

Reward.create(
  gardener_id: 3,
  giver_id: 5, 
  used: true
)

Reward.create(
  gardener_id: 3,
  giver_id: 5, 
  used: false
)

Reward.create(
  gardener_id: 3,
  giver_id: 6, 
  used: true
)

Reward.create(
  gardener_id: 3,
  giver_id: 7, 
  used: false
)

# puts "Create Conversation between Alice (Giver) and le potager de Bob (Garden)"

# message_1 = Message.create(
#   conversation_id: 1,
#   content: "Bonjour Bob, je voudrais vous déposer du compost. Etes-vous ouverts le matin ?", 
#   sender_id: 1, 
#   receiver_id: 2,
#   created_at: Time.now - 10.minutes
# )

# message_2 = Message.create(
#   conversation_id: 1,
#   content: "Bonjour Alice, merci pour votre message. Nous sommes ouverts le matin de 9h à 12h30.", 
#   sender_id: 1, 
#   receiver_id: 2,
#   created_at: Time.now - 3.minutes
# )

# message_3 = Message.create(
#   conversation_id: 1,
#   content: "Parfait, je passerai en fin de matinée. Merci et bonne journée!", 
#   sender_id: 1, 
#   receiver_id: 2,
#   created_at: Time.now + 2.minutes
# )