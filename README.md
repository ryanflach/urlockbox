# URLockbox

**Live Demo: [URLockbox](https://urlockbox.herokuapp.com/)**

URLockbox is a web application for managing links that you don't want to lose.

As a user, you are able to:
  - Create an account
  - Log in and out
  - Create, view, edit, and delete links
  - Add or remove tags to links
  - Mark a link as read or unread (read links are styled with ~~strikethrough~~ )
  - Filter links by read/unread status or by tag
  - Sort links alphabetically

This application utilizes a Rails back-end and partial JavaScript/jQuery in the front-end.

## Usage
After cloning or forking the project, `cd` into the project directory and bundle:
```
$ cd urlockbox
$ bundle
```
and initialize the database:
```
$ rake db:{create,migrate}
```
Then launch a local server:
```
$ rails s
```
And explore in a local browser at `localhost:3000`

After initializing the database (as described above), the test suite's 47 examples (86.78% coverage) can be run from the project directory with:
```
$ rspec
```
