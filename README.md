# Preparing for class

* Install the **mob** tool.  See [https://github.com/remotemobprogramming/mob](https://github.com/remotemobprogramming/mob) under “how to install.”  (Under Windows? Use git bash.)
* Clone this repo and make sure the tests run (see below for what to expect).
* We will use Kahoot! for quizzes throughout. You can either install Kahoot! on your phone, or navigate to the [web site](http://kahoot.it).
* Email me your cell number.
* Contact me if you have any problems. I am Jeff@Langrsoft.com. You can call or text me if urgent; I am at +1 719-287-4335.

# This repo

This is a hodgepodge of various bits of code. The core project is a Rails server centered around a point-of-sale (POS) interface. You'll find most exercise-related code in the app/helpers directory.

This codebase will have changed by the time you start class; be prepared to update your local copy of the repository.

Ruby version: 2.5.8

To run the tests:
```
rspec
```
You should see at least several dozen examples, 0 failures, and 13 pending. If you see something different, let me know.

# Services

You might choose to install [HTTPie](https://httpie.io) for command-line interaction with the server if needed. (Curl and other tools will also suffice.)

## Some HTTPie sample commands to interact with the routes & such:

```
http post :3000/items price=2.95 description=eggs is_exempt=false upc=12345
http post :3000/members name="Jeff Langr" phone=719-287-4335 discount=0.02

http post :3000/checkouts
http post :3000/checkouts/1/scan/12345
http get :3000/checkouts/1/total
http post :3000/checkouts/1/scan_member/719-287-4335
```

Recreating the database: 
```rake db:drop db:create db:migrate```
