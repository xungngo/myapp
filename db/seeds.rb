Role.create!([
  {name: "administrator", unique_key: "admin", display_rank: 1},
  {name: "seeker", unique_key: "seeker", display_rank: 2},
  {name: "organizer", unique_key: "organizer", display_rank: 3}
])

State.create!([
  {name: "ALABAMA", abbr: "AL"},
  {name: "ALASKA", abbr: "AK"},
  {name: "ARIZONA", abbr: "AZ"},
  {name: "ARKANSAS", abbr: "AR"},
  {name: "CALIFORNIA", abbr: "CA"},
  {name: "COLORADO", abbr: "CO"},
  {name: "CONNECTICUT", abbr: "CT"},
  {name: "DELAWARE", abbr: "DE"},
  {name: "FLORIDA", abbr: "FL"},
  {name: "GEORGIA", abbr: "GA"},
  {name: "HAWAII", abbr: "HI"},
  {name: "IDAHO", abbr: "ID"},
  {name: "ILLINOIS", abbr: "IL"},
  {name: "INDIANA", abbr: "IN"},
  {name: "IOWA", abbr: "IA"},
  {name: "KANSAS", abbr: "KS"},
  {name: "KENTUCKY", abbr: "KY"},
  {name: "LOUISIANA", abbr: "LA"},
  {name: "MAINE", abbr: "ME"},
  {name: "MARYLAND", abbr: "MD"},
  {name: "MASSACHUSETTS", abbr: "MA"},
  {name: "MICHIGAN", abbr: "MI"},
  {name: "MINNESOTA", abbr: "MN"},
  {name: "MISSISSIPPI", abbr: "MS"},
  {name: "MISSOURI", abbr: "MO"},
  {name: "MONTANA", abbr: "MT"},
  {name: "NEBRASKA", abbr: "NE"},
  {name: "NEVADA", abbr: "NV"},
  {name: "NEW HAMPSHIRE", abbr: "NH"},
  {name: "NEW JERSEY", abbr: "NJ"},
  {name: "NEW MEXICO", abbr: "NM"},
  {name: "NEW YORK", abbr: "NY"},
  {name: "NORTH CAROLINA", abbr: "NC"},
  {name: "NORTH DAKOTA", abbr: "ND"},
  {name: "OHIO", abbr: "OH"},
  {name: "OKLAHOMA", abbr: "OK"},
  {name: "OREGON", abbr: "OR"},
  {name: "PENNSYLVANIA", abbr: "PA"},
  {name: "RHODE ISLAND", abbr: "RI"},
  {name: "SOUTH CAROLINA", abbr: "SC"},
  {name: "SOUTH DAKOTA", abbr: "SD"},
  {name: "TENNESSEE", abbr: "TN"},
  {name: "TEXAS", abbr: "TX"},
  {name: "UTAH", abbr: "UT"},
  {name: "VERMONT", abbr: "VT"},
  {name: "VIRGINIA", abbr: "VA"},
  {name: "WASHINGTON", abbr: "WA"},
  {name: "WEST VIRGINIA", abbr: "WV"},
  {name: "WISCONSIN", abbr: "WI"},
  {name: "WYOMING", abbr: "WY"},
  {name: "GUAM", abbr: "GU"},
  {name: "PUERTO RICO", abbr: "PR"},
  {name: "VIRGIN ISLANDS", abbr: "VI"}
])

User.create!([
  {email: "xungngo@gmail.com", username: "xungngo", password_digest: BCrypt::Password.create('Guile!7x'), firstname: "Xung", middleinit: "V", lastname: "Ngo", address1: "11852 Medway Church Loop", city: "Manassas", state_id: 46, zipcode: '20109', uuid: SecureRandom.hex, role_ids: 1, validated_at: Time.now},
  {email: "xung@axxume.com", username: "axxume", password_digest: BCrypt::Password.create('Guile!7x'), firstname: "Xung", middleinit: "K", lastname: "Ngo", address1: "11852 Medway Church Loop", city: "Manassas", state_id: 46, zipcode: '20109', uuid: SecureRandom.hex, role_ids: 2, validated_at: Time.now},
  {email: "xungngo@hotmail.com", username: "xungngohotmail", password_digest: BCrypt::Password.create('Guile!7x'), firstname: "Michael", middleinit: "L", lastname: "Jackson", address1: "11852 Medway Church Loop", city: "Manassas", state_id: 46, zipcode: '20109', uuid: SecureRandom.hex, role_ids: 3, validated_at: Time.now}
])

Eventtype.create!([
  {name: "Live: In Person"},
  {name: "Virtual: WebCam"}
])

Eventattendee.create!([
  {name: "Anyone"},
  {name: "Adults Only"},
  {name: "Children Only"},
  {name: "Seniors Only"}
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
