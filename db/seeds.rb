# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
User.create([
  { provider: "github", uid: "545605", username: "CITguy"  },
  { provider: "github", uid: "1903562", username: "sundip" }
])

Scrap.destroy_all
Scrap.create([
  {
    user: User.first,
    is_public: false,
    endpoint: "good/morning/sunshine",
    language: "json",
    body: %Q[{\n  "earth": "hello"\n}],
    description: "Lorem ipsum dolor sit amet, vix utroque constituto id, regione inermis expetendis pri cu. Eu doctus legendos ius. Mei ea eros eirmod tincidunt, mea te dolor homero theophrastus."
  }, {
    user: User.first,
    is_public: true,
    endpoint: "goodnight",
    language: "json",
    body: %Q[[\n  "moon",\n  "room",\n  "red balloon"\n]],
    description: "Lorem ipsum dolor sit amet, vix utroque constituto id, regione inermis expetendis pri cu. Eu doctus legendos ius. Mei ea eros eirmod tincidunt, mea te dolor homero theophrastus."
  }, {
    user: User.last,
    is_public: true,
    endpoint: "hi/my/name/is",
    language: "json",
    body: %Q[{\n  "the_real": "slim shady"\n}],
    description: "Lorem ipsum dolor sit amet, vix utroque constituto id, regione inermis expetendis pri cu. Eu doctus legendos ius. Mei ea eros eirmod tincidunt, mea te dolor homero theophrastus."
  }
])
