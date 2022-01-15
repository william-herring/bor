from django.db import models
from django.contrib.auth.models import User
import random
import string


def generate_random_code():
    length = 6

    while True:
        code = random.choices(string.ascii_uppercase + string.digits, k=length)
        if Team.objects.filter(code=code).count() == 0:
            break

    return code


class Team(models.Model):
    code = models.CharField(max_length=8, default=generate_random_code, unique=True)
    leader = models.EmailField(max_length=254)
    members = models.CharField(max_length=800)
    title = models.CharField(max_length=75)


class Invite(models.Model):
    recipient = models.EmailField(max_length=254)
    join_link = models.URLField(default='localhost:3000/join')


class Project(models.Model):
    team = models.ForeignKey(Team, on_delete=models.CASCADE)
    title = models.CharField(max_length=75)
    open = models.BooleanField(default=True)


class UserStatus(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    online = models.BooleanField(default=True)
    status = models.CharField(max_length=40)
