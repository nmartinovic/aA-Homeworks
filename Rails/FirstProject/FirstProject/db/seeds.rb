# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


users = User.create([
  { username: 'Pica$$0'},
  { username: 'PeteDraws'},
  { username: 'UserThree'},
  { username: 'PinkElephuant'},
  { username: 'Whirlybro'},
  { username: 'the_curator'}
  ])

artworks = Artwork.create([
  { title: '7h3 scr33m', image_url: 'thepicasso.com/scream', artist_id: users[0].id},

  { title: 'Banister', image_url: 'interiordiycorating.com/stairwell', artist_id: users[1].id},

  { title: 'Elephant Talk', image_url: 'elephantland.org/baby_elephants_talking_so_cute', artist_id: users[3].id},

  { title: 'Rotator ANNIHILATION', image_url: 'princeton.edu/chad_a_mcmasters/portfolio/rotator_annihilation', artist_id: users[4].id},

  { title: 'New Software :)', image_url: 'trollnet.com/malware_images/troian_equestarianist', artist_id: users[2].id}
  ])

  artwork_shares = ArtworkShare.create([
    { artwork_id: artworks[4].id, viewer_id: users[1].id},
    { artwork_id: artworks[3].id, viewer_id: users[2].id},
    { artwork_id: artworks[2].id, viewer_id: users[3].id},
    { artwork_id: artworks[1].id, viewer_id: users[4].id},
    { artwork_id: artworks[4].id, viewer_id: users[4].id},
    { artwork_id: artworks[0].id, viewer_id: users[1].id},
    { artwork_id: artworks[3].id, viewer_id: users[0].id},
    ])