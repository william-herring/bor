# Bor
<img src="https://img.shields.io/github/stars/william-herring/bor"> <img src="https://img.shields.io/github/forks/william-herring/bor"> <img src="https://img.shields.io/github/issues/william-herring/bor"> <img src="https://img.shields.io/github/license/william-herring/bor">


Bor is an app for managing projects in a team of any size.
The app offers many tools and features to create a tailored
workflow.

1. [ Developer guide ](#devg)
    - [ Info ](#dginfo)
    - [ Setup ](#dgsetup)
    - [ Run the dev server ](#dgserver)
    - [ Run the client in dev mode ](#dgclient)
    - [ Pick an issue ](#dgissues)
    - [ Submit a pull request ](#dgpr)

<a name="devg"></a>
## Developer guide
Bor is maintained by a single person, so it helps to turn this
into a community-developed project to ensure that quality of Bor is top-notch.
This developer huide should have everything you need to know to help contribute.

<a name="dginfo"></a>
### Info

Bor is currently designed to run on the web, iPadOS, iOS and Android.
Ensure you have Python 3.9 or higher installed and
the latest version of Flutter.
You should be familiar with the following:

| Framework/Library     | Use case         | Language  |
|-----------------------|------------------|-----------|
| Django                | Server(REST API) | Python    |
| Flutter               | Client           | Dart      |
| Django Rest Framework | Server(REST API) | Python    |

<a name="dgsetup"></a>
### Setup

Firstly, clone the repository.

(~/mysites)
```bash
git clone https://github.com/william-herring/bor.git
```

You will then need to install the dependencies from pubspec.yaml.

(bor/client)
```bash
flutter pub get
```

<a name="dgserver"></a>
### Run the dev server

Before we begin, you will have to install the required packages.

(bor/server)
```bash
pip3 install -r REQUIREMENTS.txt
```

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

It is recommended that you run on the web, to allow easy window resizing.

(bor/client)
```bash
flutter run
```

<a name="dgissues"></a>
### Pick an issue

Primarily, you should be making changes to the
codebase that target problems or suggestions in the
<a href="https://github.com/william-herring/bor/issues">issues tab</a>.


<a name="dgpr"></a>
### Submit a pull request
Submit a pull request when you believe that the changes are necessary, tested and
of **high quality**. When you create a pull request, ensure that you do not delete
the template. Anything that does not match the template will be closed.
