puts "🧹 Limpando dados existentes..."
Payment.destroy_all
Ticket.destroy_all
Seat.destroy_all
Showtime.destroy_all
Room.destroy_all
RoomModel.destroy_all
Theater.destroy_all
MoviesGenre.destroy_all
Genre.destroy_all
Movie.destroy_all
User.destroy_all

puts "🌱 Populando banco de dados..."

# USERS
users = User.create!([
  { email_address: "joao@email.com", password_digest: "123456", first_name: "João", last_name: "Parker" },
  { email_address: "maria@email.com", password_digest: "123456", first_name: "Maria", last_name: "Parker" }
])

# MOVIES
movies = Movie.create!([
  { name: "Duna 2", description: "Epico no deserto", release_date: "2024-02-28", country_code: "US", original_language: "en", duration_in_minutes: 166 },
  { name: "Ainda Estou Aqui", description: "Drama brasileiro", release_date: "2024-09-18", country_code: "BR", original_language: "pt", duration_in_minutes: 135 }
])

# GENRES
genres = Genre.create!([
  { name: "Ação" },
  { name: "Drama" }
])

# MOVIES_GENRES
MoviesGenre.create!([
  { movie: movies[0], genre: genres[0], main_genre: true },
  { movie: movies[1], genre: genres[1], main_genre: true }
])

# THEATERS
theaters = Theater.create!([
  { name: "Cinemark Center Norte", address: "Av. Otto Baumgart, 500", country_code: "BR" }
])

# ROOM_MODELS
room_models = RoomModel.create!([
  { name: "Sala Pequena", rows_count: 3, columns_count: 3 }
])

# ROOMS
rooms = Room.create!([
  { name: "Sala 1", theater: theaters[0], room_model: room_models[0] }
])

# SEATS
rows = [ "A", "B", "C" ]
rooms.each do |room|
  rows.each_with_index do |row, i|
    (1..3).each do |col|
      Seat.create!(room: room, row: row, column: col, number: "#{row}#{col}")
    end
  end
end

# SHOWTIMES
showtimes = Showtime.create!([
  { movie: movies[0], room: rooms[0], start_at: Time.current + 1.day, language: "en", subtitle: "pt", full_price: 32.00 },
  { movie: movies[1], room: rooms[0], start_at: Time.current + 2.days, language: "pt", subtitle: nil, full_price: 28.00 }
])

# TICKETS
Ticket.create!([
  { showtime: showtimes[0], user: users[0], seat: Seat.first, status: "complete" },
  { showtime: showtimes[0], user: users[1], seat: Seat.second, status: "pending" }
])

# PAYMENTS
Payment.create!([
  { ticket: Ticket.first, amount: 32.00, payment_method: "pix", transaction_id: "tx_001", status: "paid", paid_at: Time.current, card_last_four: nil, gateway_response: "ok" }
])

puts "✅ Pronto! #{User.count} users, #{Movie.count} filmes, #{Showtime.count} sessões, #{Ticket.count} ingressos"
