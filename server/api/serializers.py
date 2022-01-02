from rest_framework.serializers import ModelSerializer
from django.contrib.auth.models import User
from rest_framework.validators import UniqueTogetherValidator

from .models import Team


class UserSerializer(ModelSerializer):
    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

    class Meta:
        model = User
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'password',
        )

        # The following validator is needed to ensure that any combination of username/email must be unique.
        # This allows only one account per email.
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=['username', 'email']
            )
        ]


class TeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = '__all__'


class CreateTeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = ('leader', 'title')
