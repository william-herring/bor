from django.db import models
from django.contrib.auth.models import User
import random
import string


def generate_random_code():
    length = 6

    while True:
        code = "".join(random.choices(string.ascii_uppercase + string.digits, k=length))
        if Team.objects.filter(code=code).count() == 0:
            break

    return code


class Team(models.Model):
    code = models.CharField(max_length=8, default=generate_random_code, unique=True)
    leader = models.EmailField(max_length=254)
    members = models.CharField(max_length=800)
    title = models.CharField(max_length=75)


class Invite(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    recipient = models.EmailField(max_length=254)
    join_code = models.CharField(default="", max_length=500)


class Project(models.Model):
    team_code = models.CharField(max_length=8)
    title = models.CharField(max_length=75)
    description = models.CharField(max_length=150)
    open = models.BooleanField(default=True)


class UserStatus(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    online = models.BooleanField(default=True)
    status = models.CharField(max_length=40)
