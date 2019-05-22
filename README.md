# Smart Order:

Let's focus how to help the customber with better "Basket Building" strategy. 

## Problem statement:

In Groceries, most of time the customber order 61% same product basket-wise (per weekly). The user needs more frictionless 
application where the application understands the customber end to end.

<b>

(1). User has to search for each item individually.

(2). From search results, it is hard for the user to identify preferred items. reduce the pain-point.

(3). User can miss out on adding certain regularly bought items because they were not suggested anywhere in their journey. 61% of loyal customber basket has exact same items to purchased in past orders. Out of remaining 39%, 25% have similar item being purchased in the past. 

(4). Users keep purchasing the same set of products because complementary/bought-together items are not suggested to the users in the browse path. We do not help our customers to make puchase decision. 

(5). Users can run out of certain groceries as they forgot to restock on those.

(6). Users can miss out on better prices because they are unaware of price hikes in the near future, or of good offers available.

</b>

## Solution:

<b>
(1). Using voice based chatBot the app is capturing the shopping list from the user to avoid multiple search.
  
(2). prepare the cart with generic inputs like “milk” and mapping it with right products based the user order history.

(3). Building true omnichannel experience by communicating in-club price drop, promotions in-app notification.

(4). Suggesting missing items to the user based on his/her past order

(5) allowing the user to choose substitute products (similar products) and recommendation (bought together) for each product

(6). Remind the user to restock their items based on their purchase interval through push notification (Restock capabilities).

</b>

### Demo:

https://www.youtube.com/watch?v=mcVX0vnrHHA

### Architecture:

![Groceries Hackathon Prototype](https://user-images.githubusercontent.com/10649284/55541777-4c595a80-56e3-11e9-8694-aee8f78febbd.png)


### Product Catalog (You can add the following items to your basket)
<img width="839" alt="Screen Shot 2019-04-02 at 2 13 41 PM" src="https://user-images.githubusercontent.com/10649284/55813677-cbe39100-5b0a-11e9-95a6-270e062790a9.png">

### Login:

![IMG_9B4AF9FFC5CB-1](https://user-images.githubusercontent.com/10649284/55812630-f2a0c800-5b08-11e9-80db-09e96c60a6c7.jpeg)

### Chat Bot:
![IMG_9CD0F3B854F0-1](https://user-images.githubusercontent.com/10649284/55812684-09dfb580-5b09-11e9-8693-04fe554d93ef.jpeg)
![IMG_5279FDD3B1C2-1](https://user-images.githubusercontent.com/10649284/55813821-17963a80-5b0b-11e9-8293-94553c8c4482.jpeg)

### Remove product and show list in chatBot:
![IMG_74DEEE32C340-1](https://user-images.githubusercontent.com/10649284/55812772-35fb3680-5b09-11e9-906b-be9a1efc843a.jpeg)

### Product List Page (Only one search, not multiple search based on shopping list and the item has been selected based on past purchase history, missing items has been informed to the user)
![IMG_22D32AF78C37-1](https://user-images.githubusercontent.com/10649284/55812875-6347e480-5b09-11e9-8f1a-83caf8fb3ece.jpeg)
![IMG_24ED43920FC9-1](https://user-images.githubusercontent.com/10649284/55813182-fda82800-5b09-11e9-94fe-696a9d69cfef.jpeg)

### Product Details Page (it also contains similar product which belongs to same category)
![IMG_473C96107FB7-1](https://user-images.githubusercontent.com/10649284/55813252-1c0e2380-5b0a-11e9-8b18-acf3c0af45d9.jpeg)

### Product Details page (It shows Bought Together products based on the user trend)
![IMG_FAF3EDC13C3E-1](https://user-images.githubusercontent.com/10649284/55813400-54adfd00-5b0a-11e9-9274-98dc73c349ca.jpeg)



