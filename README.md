# Bor

Bor is a platform for managing work in a team of any size.
The app offers many tools and features to create a tailored 
workflow. 

1. [ Developer guide ](#devg)
    - [ Info ](#dginfo)
    - [ Setup ](#dgsetup)
    - [ Run the dev server ](#dgserver)
    - [ Run the client in dev mode ](#dgclient)
    - [ Pick an issue ](#dgissues)

<a name="devg"></a>
## Developer guide
Bor is maintained by a single person, so it helps to turn this 
into a community-developed project to ensure that quality of Bor is top-notch.
This developer huide should have everything you need to know to help contribute.

<a name="dginfo"></a>
### Info

Ensure you have Python 3.9 or higher installed and 
the latest version of Node.
You should be familiar with the following:

| Framework/Library     | Use case         | Language  |
|-----------------------|------------------|-----------|
| Django                | Server(REST API) | Python    |
| React                 | Client           | Typescript|
| Django Rest Framework | Server(REST API) | Python    |
| TailwindCSS           | Client/Styling   | CSS/JS    |

<a name="dgsetup"></a>
### Setup

Firstly, clone the repository.

(~/mysites)
```bash
git clone https://github.com/william-herring/bor.git
```

You will then need to install the dependecies from package.json 
with NPM.

(bor/client)
```bash
npm install
```

<a name="dgserver"></a>
### Run the dev server

Remember to always migrate changes to the database before starting the server.

(bor/server)
```bash
python3 manage.py makemigrations
python3 manage.py migrate
```

Run the server as per the regular Django CLI command.
(bor/server)
```bash
python3 manage.py runserver
```

<a name="dgclient"></a>
### Run client in dev mode
(bor/client)
```bash
npm start
```

<a name="dgissues"></a>
### Pick an issue

Primarily, you should be making changes to the 
codebase that target problems or suggestions in the 
<a href="https://github.com/william-herring/bor/issues">issues tab</a>.


