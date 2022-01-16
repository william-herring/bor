from rest_framework.serializers import ModelSerializer, CharField, EmailField, Serializer
from .models import Team, Invite
from django.contrib.auth.models import User


class UserSerializer(ModelSerializer):
    password = CharField(write_only=True)
    email = EmailField()

    def create(self, validated_data):

        user = User.objects.create_user(
            email=validated_data['email'],
            username=validated_data['username'],
            password=validated_data['password'],
        )

        return user

    class Meta:
        model = User
        fields = ('id', 'username', 'password', 'email')


class TeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = '__all__'


class CreateTeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = ('title',)


class UpdateTeamSerializer(ModelSerializer):
    class Meta:
        model = Team
        fields = ('title', 'leader', 'code')


class InviteSerializer(ModelSerializer):
    class Meta:
        model = Invite
        fields = '__all__'
