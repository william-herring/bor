from rest_framework.serializers import ModelSerializer
from .models import Team


class TeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = '__all__'


class CreateTeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = ('leader', 'title')


class UpdateTeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = ('title', 'leader', 'code')
