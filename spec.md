# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - I required the Sinatra Gem for this lab. Sinatra is a Domain Specific Language (or a framework) that is used to create web applications.
- [x] Use ActiveRecord for storing information in a database - I required ActiveRecord Gem. ActiveRecord is a Ruby library that works with relational SQL databases to provide Object Relational Mapping. It's features include, mapping a single ruby object to a database table, accessing columns through methods, and inferring from database schema (using Primary keys and Foriegn keys). In other words, we use ActiveRecord to store our newly created objects in a database. ActiveRecord allows us to represent, models and their data, associations between those models, and inheritance heirarchies through related models. It also gives us the ability to validate the data before persisting to the database.
- [X] Include more than one model class (list of model class names e.g. User, Post, Category) - I created two models. Event and User.
- [X] Include at least one has_many relationship (x has_many y e.g. User has_many Posts) - A User has_many Events.
- [X] Include user accounts - I created a few dummy users
- [x] Ensure that users can't modify content created by other users - I have prevented a user from modifying others' content by setting the session[:user_id] == event.user_id
- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - Events belong_to a User. I have setup routes to create, view, update, and delete an event.
- [X] Include user input validations - I have validations in place to verify a user password. If a User input cannot be validated, they are redirected to the login page. I have also put in validations for the edit page, so the user knows that all fields are required.
- [X] Display validation failures to user with error message (example form URL e.g. /posts/new) - Displayed error message when edit, login weren't valid, and success messages when edit, delete and logout were successful
- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - I attached a LICENSE.md and CONTRIBUTING.md file to this application and provided a link to view in browser.

Confirm
- [X] You have a large number of small Git commits - I think so
- [X] Your commit messages are meaningful - I hope so
- [X] You made the changes in a commit that relate to the commit message- Yes, I believe so
- [X] You don't include changes in a commit that aren't related to the commit message - I tried not to - so hopefully, no
