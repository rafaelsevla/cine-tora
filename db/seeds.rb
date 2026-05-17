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
UserHasUserGroup.destroy_all
UserGroup.destroy_all
GroupPermission.destroy_all
User.destroy_all

puts "🌱 Populando banco de dados..."

# ==================== GRUPOS E PERMISSÕES ====================
puts "👥 Criando grupos e permissões..."

admin_group = UserGroup.create!(name: "Administradores")
staff_group = UserGroup.create!(name: "Funcionários")

# Permissões do admin
GroupPermission.create!(user_group: admin_group, permission: "admin_access")
GroupPermission.create!(user_group: admin_group, permission: "manage_movies")
GroupPermission.create!(user_group: admin_group, permission: "manage_theaters")
GroupPermission.create!(user_group: admin_group, permission: "manage_showtimes")
GroupPermission.create!(user_group: admin_group, permission: "view_reports")

# Permissões do funcionário
GroupPermission.create!(user_group: staff_group, permission: "manage_showtimes")
GroupPermission.create!(user_group: staff_group, permission: "view_reports")

# ==================== USERS ====================
puts "👥 Criando usuários..."

users = User.create!([
  { email_address: "admin@cinetora.com", password: "123456", password_confirmation: "123456", first_name: "Admin", last_name: "Sistema" },
  { email_address: "joao@cinetora.com", password: "123456", password_confirmation: "123456", first_name: "João", last_name: "Silva" },
  { email_address: "maria@cinetora.com", password: "123456", password_confirmation: "123456", first_name: "Maria", last_name: "Santos" }
])

# Vincular admin ao grupo de administradores
UserHasUserGroup.create!(user: users[0], user_group: admin_group)

# Vincular usuários comuns ao grupo de funcionários (opcional, só se quiser que eles acessem admin)
# UserHasUserGroup.create!(user: users[1], user_group: staff_group)
# UserHasUserGroup.create!(user: users[2], user_group: staff_group)

puts "   ✅ Admin: admin@cinetora.com / 123456"
puts "   ✅ Usuários comuns: joao@cinetora.com / 123456, maria@cinetora.com / 123456"

# ==================== MOVIES ====================
puts "🎬 Criando filmes..."

movies = Movie.create!([
  { name: "Duna 2", description: "Epico no deserto", release_date: "2024-02-28", country_code: "US", original_language: "en", duration_in_minutes: 166 },
  { name: "Ainda Estou Aqui", description: "Drama brasileiro", release_date: "2024-09-18", country_code: "BR", original_language: "pt", duration_in_minutes: 135 }
])

# ==================== GENRES ====================
puts "🎭 Criando gêneros..."

genres = Genre.create!([
  { name: "Ação" },
  { name: "Drama" }
])

# ==================== MOVIES_GENRES ====================
puts "🔗 Associando filmes aos gêneros..."

MoviesGenre.create!([
  { movie: movies[0], genre: genres[0], main_genre: true },
  { movie: movies[1], genre: genres[1], main_genre: true }
])

# ==================== THEATERS ====================
puts "🏢 Criando cinemas..."

theaters = Theater.create!([
  { name: "Cinemark Center Norte", address: "Av. Otto Baumgart, 500", country_code: "BR" }
])

# ==================== ROOM_MODELS ====================
puts "📐 Criando modelos de sala..."

room_models = RoomModel.create!([
  { name: "Sala Pequena", rows_count: 3, columns_count: 3 }
])

# ==================== ROOMS ====================
puts "🏛️ Criando salas..."

rooms = Room.create!([
  { name: "Sala 1", theater: theaters[0], room_model: room_models[0] }
])

# ==================== SEATS ====================
puts "💺 Criando assentos..."

rows = [ "A", "B", "C" ]
rooms.each do |room|
  rows.each_with_index do |row, i|
    (1..3).each do |col|
      Seat.create!(room: room, row: row, column: col, number: "#{row}#{col}")
    end
  end
end

puts "   ✅ #{Seat.count} assentos criados"

# ==================== SHOWTIMES ====================
puts "📅 Criando sessões..."

showtimes = Showtime.create!([
  { movie: movies[0], room: rooms[0], start_at: Time.current + 1.day, language: "en", subtitle: "pt", full_price: 32.00 },
  { movie: movies[1], room: rooms[0], start_at: Time.current + 2.days, language: "pt", subtitle: nil, full_price: 28.00 }
])

# ==================== TICKETS ====================
puts "🎟️ Criando ingressos..."

Ticket.create!([
  { showtime: showtimes[0], user: users[1], seat: Seat.first, status: "complete" },
  { showtime: showtimes[0], user: users[2], seat: Seat.second, status: "pending" }
])

# ==================== PAYMENTS ====================
puts "💳 Criando pagamentos..."

Payment.create!([
  { ticket: Ticket.first, amount: 32.00, payment_method: "pix", transaction_id: "tx_001", status: "paid", paid_at: Time.current, card_last_four: nil, gateway_response: "ok" }
])

puts ""
puts "✅ Pronto! Resumo:"
puts "   👥 #{User.count} usuários (1 admin, 2 comuns)"
puts "   🎬 #{Movie.count} filmes"
puts "   🎭 #{Genre.count} gêneros"
puts "   🏢 #{Theater.count} cinema"
puts "   🏛️ #{Room.count} sala"
puts "   💺 #{Seat.count} assentos"
puts "   📅 #{Showtime.count} sessões"
puts "   🎟️ #{Ticket.count} ingressos"
puts "   💳 #{Payment.count} pagamento"
puts ""
puts "🔐 Acesso Admin: admin@cinetora.com / 123456"
