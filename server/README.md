# Development server

The dev server is a mock of the server that will eventually be used in production.
Obviously, the database and SECRET-KEY will be different, for security reasons. 


## About
Bor uses a [REST API](https://www.redhat.com/en/topics/api/what-is-a-rest-api), which enables the client to access
data quickly and easily. To build the API, Bor is using Django REST Framework. You can access
the documentation [here](https://www.django-rest-framework.org/). The backend of Bor can be slightly more difficult, 
particularly for beginners or developers who are inexperienced with these technologies. 

SQLite3 serves as the database for Bor. SQLite3 comes as the default database when creating a Django project, and it should
work just fine for a project like Bor. If we require a larger or more complex database as we get more users, it may be worth considering
alternatives like PostgreSQL, but for the time being, it will stay as SQLite3. The database can be located in the server's root
directory, with the filename 'db.sqlite3'. The database is very easy to use with Django, because all data objects are written
as [models](https://docs.djangoproject.com/en/4.0/topics/db/models/).

## Documentation

### Authentication
Bor uses JWT for authentication (authtoken, provided by Django REST Framework). The token is generated when a user logs in or signs out.
Whenever the API receives a request that requires authentication, the token must be provided in the header.

Eg.
```json
{ "Authorization": "Token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" }
```

Failing to provide authentication, will result in a 401 Unauthorized response. 