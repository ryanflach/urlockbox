# URLockbox

**Live Demo: [URLockbox](https://urlockbox.herokuapp.com/)**

URLockbox is a web application for managing links that you don't want to lose.

A user is able to create an account and log in. Once logged in, they can add, edit, and mark links as read or unread.

This application utilizes a Rails back-end and partial JavaScript/jQuery in the front-end.

## Usage
After cloning or forking the project, bundle:
```
bundle
```
and initialize the database:
```
rake db:{create,migrate}
```
Then launch a local server:
```
rails s
```
And explore in a local browser at `localhost:3000`
