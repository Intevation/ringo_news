# News extension for the Ringo webframework
This extension can be used to extend a Ringo based web application with a
newsboard. News can be displayed in the application. News can be administrated
either throuh the webinterface or a command line client.

## Installation
For details on how to install this extension in your application please refer
to [The ringo documentation for extensions](http://ringo.readthedocs.org/en/latest/development/extension.html)

## CLI
The extension provides some additional CLI options to manage new directly on
the server:

* ringo-admin news add `<jsonfile>`
  (The add command can be used to either add new or update existing news
  items.)
* ringo-admin news delete `<id>`

JSON:

```json
{"subject": "Foo", "date": "YYYY-MM-DD", "text": "Foo text the body of the
message"}
```

If the json contains an `id` then the command will try to load the item with
the given id and update the news in the database. In all other cases
(including giving no id at all) will create a new news item with a new `id`
will be generated.

On default the added news will be added  to all users in the system. Later
enhancements might be giving a list of usernames, filtering by groups and
roles etc.

As this command basically utilize the import of ringo like the `ringo-admin db
loadata` command it is capable of doing almost the same things (e.g defining
relation)
