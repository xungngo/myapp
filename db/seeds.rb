Role.create!([
  {name: "administrator", unique_key: "admin", display_rank: 1},
  {name: "seeker", unique_key: "seeker", display_rank: 2},
  {name: "organizer", unique_key: "organizer", display_rank: 3}
])

User.create!([
  {email: "xungngo@gmail.com", username: "xungngo", password_digest: BCrypt::Password.create('2005Guile!7x'), firstname: "david", middleinit: "V", lastname: "smith", address: "11852 Medway Church Loop, Manassas, VA", uuid: SecureRandom.hex, role_ids: 1},
  {email: "xung@axxume.com", username: "xung", password_digest: BCrypt::Password.create('2005Guile!7x'), firstname: "david", middleinit: "V", lastname: "smith", address: "11852 Medway Church Loop, Manassas, VA", uuid: SecureRandom.hex, role_ids: 2},
  {email: "xungngo@hotmail.com", username: "xungngo3", password_digest: BCrypt::Password.create('2005Guile!7x'), firstname: "david", middleinit: "V", lastname: "smith", address: "11852 Medway Church Loop, Manassas, VA", uuid: SecureRandom.hex, role_ids: 3}
])

Marker.create!([
  {name: "Manassas Park", address: "Manassas Park VA US", latitude: "38.784003", longitude: "-77.469711", active: true},
  {name: "Manassas Mall", address: "8300 Sudley Rd Manassas", latitude: "38.773324", longitude: "-77.505326", active: true},
  {name: "Manassas National Battlefield Park", address: "6511 Sudley Rd Manassas", latitude: "38.813412", longitude: "-77.522168", active: true},
  {name: "Lake Manassas Drive", address: "Lake Manassas Dr Gainesville Brentsville", latitude: "38.786115", longitude: "-77.646402", active: true},
  {name: "Manassas Downtown Post Office", address: "9108 Church St Manassas", latitude: "38.751778", longitude: "-77.473217", active: true},
  {name: "Regal Cinemas Virginia Gateway 14 & RPX", address: "8001 Gateway Promenade Pl Gainesville", latitude: "38.787121", longitude: "-77.60575", active: true},
  {name: "Jiffy Lube Live", address: "7800 Cellar Door Dr Bristow", latitude: "38.785706", longitude: "-77.587311", active: true},
  {name: "Manassas Regional Airport", address: "10600 Harry J Parrish Blvd Manassas", latitude: "38.725575", longitude: "-77.512319", active: true},
  {name: "Costco Wholesale", address: "Manassas Gainesville Prince William County", latitude: "38.783511", longitude: "-77.516895", active: true},
  {name: "Prince William Forest Park", address: "18170 Park Entrance Rd, Triangle, VA 22172, USA", latitude: "38.591005", longitude: "-77.38285"},
  {name: "Potomac Mill", address: "2700 Potomac Mills Cir, Woodbridge, VA 22192, USA", latitude: "38.643422", longitude: "-77.295341"},
  {name: "Sandy Run Regional Park", address: "10249-10253 Van Thompson Rd, Fairfax Station, VA 22039, USA", latitude: "38.710027", longitude: "-77.303753"},
  {name: "Fountainhead Regional Park", address: "Outlet, Fairfax Station, VA 22039, USA", latitude: "38.721144", longitude: "-77.33345"},
  {name: "Hemlock Overlook Regional Park", address: "13269-13299 Yates Ford Rd, Clifton, VA 20124, USA", latitude: "38.77028", longitude: "-77.409668"},
  {name: "Westfields Golf Club", address: "13940 Balmoral Greens Ave, Clifton, VA 20124, USA", latitude: "38.795437", longitude: "-77.424946"},
  {name: "Bristow Manor Golf Club", address: "11507 Valley View Dr, Bristow, VA 20136, USA", latitude: "38.705606", longitude: "-77.531033"}
])
