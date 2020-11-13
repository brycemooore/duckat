# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def time_rand
    Time.new(2020, rand(11..12), rand(14..30)) 
end

duck_images = ['https://cdn.shopify.com/s/files/1/0030/4227/9494/products/mgs-solid-snake-tubbz-gs-01_800x.progressive.jpg?v=1592352398',
'https://images-na.ssl-images-amazon.com/images/I/51VXgNZFIoL._AC_SL1424_.jpg',
'https://www.amsterdamduckstore.com/wp-content/uploads/2019/12/Green-rubber-duck-front-Amsterdam-Duck-Store.jpg',
'https://cdn11.bigcommerce.com/s-nf2x4/images/stencil/1280x1280/products/499/10540/pink-Rubber-Duck-ad-line-2__06763.1576270568.jpg?c=2',
'https://cdn.shopify.com/s/files/1/0604/4801/products/Elvis_1-min-min_1644x.jpg?v=1568680762',
'https://www.mastgeneralstore.com/prodimages/54042-DEFAULT-l.jpg',
'https://lilalu-shop.com/media/image/e8/3e/74/lilalu-quietscheente-sm-sadomaso-erotik-sex-toys-rubber-duck-eroticism-emotion_600x600.jpg',
'https://partycity6.scene7.com/is/image/PartyCity/_pdp_sq_?$_1000x1000_$&$product=PartyCity/788220_01',
'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRdTN9mgPlBZH8By1PjaBJrqV8m9lashwfAcQ&usqp=CAU']

User.destroy_all
Item.destroy_all
Bid.destroy_all
Tag.destroy_all
Comment.destroy_all
ItemTag.destroy_all

20.times do
    u = User.create(username: Faker::Artist.unique.name, password: 'adminpass', balance: 0)
    rand(2..4).times do
        u.add_item(Faker::Space.company + " Duck", Faker::GreekPhilosophers.quote, rand(5..30).to_f, time_rand, duck_images.sample)
    end 
end


