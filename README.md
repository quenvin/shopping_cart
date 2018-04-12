[![CircleCI](https://circleci.com/gh/Fredricktgl/shopping_cart/tree/master.svg?style=svg)](https://circleci.com/gh/Fredricktgl/shopping_cart/tree/master)

# Shopping Cart

This is a shopping cart application. To visit this site, [AppName](https://ac-shopping-cart.herokuapp.com)

# Setup

1. Clone the application into the selected folder.
```
git clone https://github.com/Fredricktgl/shopping_cart.git
```

2. Run bundle 
```
cd shopping_cart
bundle
```

3. Setup the database
```
rake db:create db:migrate db:seed
```
#To try out admin functions, please login using the following
Email: admin@admin.com
password: 123456

#To test out payments, please use the following test credentials provided by Braintree
https://developers.braintreepayments.com/guides/credit-cards/testing-go-live/php
