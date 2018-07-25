# item-share-app

// description (of app, of problem that app addresses, solution that app provides)\
// stories for app -> nick just moved to LA, needed to borrow a few things real quick, etc\
// user stories/features -> required, optional\
// wireframes

### Potential Titles
- Fetch
- Grab


### Description
An item-sharing app.  

Have you ever needed to borrow a leaf blower for a few hours but didn't have the money or space to justify the buy? What about a weed whacker that you'd only use a few times a year? 

With [insert name here], you can easily rent and return items from around your neighborhood. Whether it's for a few hours or a few days, you can sell and rent items at your leisure. Just specify a time interval and you're good to go. Instead of spending hours online researching the cheapest places to rent a Mac, with [insert name here], you can do it from the ease of your neighborhood. It's as simple as a click and a pick. 

### User Stories 

Required

[x] User can use the interactive map to find items being shared nearby\
[x] User can click on the items being displayed on the map to see a detailed screen for the item\
[x] user can see when item is available\
[ ] user can book the item\
[ ] User will be charged through Stripe

Optional

[ ] Searching more efficient (only filter for if first letters match)
[ ] User can search for an item they wish to rent\
    [x] Create categories that the user can search within\
[ ] User can cancel their booking within the detailed item view\
[ ] The user is not charged until pickup is confirmed by the person who is getting item (back)\
[ ] Owner will be paid through Stripe\
[x] Posting available items\
[ ] User can can tap map for a CLLocation or convert address to a CLLocation\
[x] Asking user for permission for location services\
[ ] Map doesn't show all items on map, just items in given radius\
[x] When searching, results are diacritic and space insensitive\
[ ] User can change location from which they are searching from\
[ ] User gets email when item is booked


Stretch

[x] Login/Signup\
[ ] Profile tab with user's history (checked-out items, sold items, history)\
[ ] Phone numbers exchanged once they have booked the item\
[ ] Specifications about your item\
[ ] Apple maps clustering\
[ ] and the item's owner will be notified\


extra extra extra

[ ] picture attached with the item\
[ ] request an item that isn't currently on the app\
[ ] notifications\
[ ] subscription service\
[ ] messaging\
[ ] history\
[ ] reviews and ratings\
[ ] frequently used\
[ ] radii for the map\


### Characters
Lola has always wanted to use a riding lawn mower, just for kicks. But, her family doesn't own one and neither do any of her friends' families, and there's no way they would ever buy one. So, she uses [insert name here] to borrow one for a few hours when her grass gets high enough and gets to cross an item off her bucket list. 

Ever since visiting a bakery in Italy, Sebastian has wanted to try his hand at baking bread. However, he'd first like to try out breadmaking before seeing if he'll keep it up as a regular thing, and thus doesn't want to buy a breadmaker just for this one bake. With [insert name here] he can easily search for and borrow a breadmaker from around his area before making the big decision. 

Millie just moved two states over for her new job. She didn't bring much more than the basic essentials, as she was alone on the move. Since she is currently staying in a temporary apartment for a week or two before she can move into her actual apartment, she doesn't want to unpack much, nor go on a huge shopping spree and have to lug everything to her new apartment. But anytime she wants rice, she can pop down the block for a rice cooker for a few hours without having to buy one yet. When her woolen shirt tears a bit in the harsh washing machines, she can easily borrow a sewing machine for an easy and cheap fix. With [insert name here], Millie can get everything she needs without the hassle of shopping and buying. 

### Data Schema
Database for Item:\
Category\
Owner\
Title\
Description\
Picture\
Address\
Price\
Location\
(something for time booking perhaps booleans in an array)\
objectID\
booked now boolean\
dictionary of arrays of ns dates\
Pickup confirmed?



