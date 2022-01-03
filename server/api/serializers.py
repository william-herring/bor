from rest_framework.serializers import ModelSerializer
from django.contrib.auth.models import User
from rest_framework.validators import UniqueTogetherValidator

from .models import Team


class TeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = '__all__'


class CreateTeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = ('leader', 'title')
