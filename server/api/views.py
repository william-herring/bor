from rest_framework.generics import ListAPIView, CreateAPIView
from rest_framework.views import APIView
from rest_framework import permissions
from .models import Team
from rest_framework.status import *
from rest_framework.response import Response
from django.contrib.auth.models import User
from .serializers import *


class UserView(ListAPIView):
    permission_classes = [
        permissions.IsAdminUser
    ]

    queryset = User.objects.all()
    serializer_class = UserSerializer


class CreateUserView(CreateAPIView):
    model = User
    serializer_class = UserSerializer
    permission_classes = [
        permissions.AllowAny  # This allows unauthenticated users to register an account
    ]


class GetUsernameView(APIView):
    permission_classes = [
        permissions.IsAuthenticated
    ]

    def get(self, request, format=None):
        try:
            username = request.user.username
            return Response({'Username': username}, status=HTTP_200_OK)
        except:
            return Response({'Bad Request': 'Failed to retrieve user data'}, status=HTTP_400_BAD_REQUEST)


class TeamView(ListAPIView):
    queryset = Team.objects.all()
    serializer_class = TeamSerializer
    permission_classes = [
        permissions.IsAdminUser
    ]


class GetUserTeams(ListAPIView):
    serializer_class = TeamSerializer
    permission_classes = [
        permissions.IsAuthenticated
    ]

    def get_queryset(self):
        teams = Team.objects.filter(members__icontains=self.request.user.email)

        return teams


class CreateTeamView(APIView):
    serializer_class = CreateTeamSerializer
    permission_classes = [
        permissions.IsAuthenticated
    ]

    def post(self, request, format=None):
        if not self.request.session.exists(self.request.session.session_key):
            self.request.session.create()

        serializer = self.serializer_class(data=request.data)
        if serializer.is_valid():
            usr_email = str(request.user.email)
            leader = usr_email
            title = serializer.data.get('title')
            print(usr_email)
            members = f'{leader}, '
            team = Team(leader=leader, title=title, members=members)
            team.save()
            self.request.session['team_code'] = team.code
            return Response(TeamSerializer(team).data, status=HTTP_201_CREATED)

        return Response({'Bad Request': 'Invalid serializer'}, status=HTTP_400_BAD_REQUEST)


# In future, this view should validate that the user requesting to edit, is also logged in with an email matching
# that of the team leader.
class UpdateTeamView(APIView):
    serializer_class = UpdateTeamSerializer
    permission_classes = [
        permissions.IsAuthenticated
    ]

    def patch(self, request, format=None):
        serializer = self.serializer_class(data=request.data)

        if serializer.is_valid():
            code = request.data.get('code')
            team_result = Team.objects.filter(code=code)
            if len(team_result) > 0:
                team = team_result[0]
                title = serializer.data.get('title')
                leader = serializer.data.get('leader')
                team.title = title
                team.leader = leader
                team.save(update_fields=['title', 'leader'])
                return Response(TeamSerializer(team).data, status=HTTP_200_OK)
            return Response({'Not Found': 'Team does not exist'}, status=HTTP_404_NOT_FOUND)

        return Response({'Bad Request': 'Invalid serializer'}, status=HTTP_400_BAD_REQUEST)


# In future, this view should validate that the user requesting to delete, is also logged in with an email matching
# that of the team leader.
class DeleteTeamView(APIView):
    lookup_url_kwarg = 'code'
    permission_classes = [
        permissions.IsAuthenticated
    ]

    def post(self, request, format=None):
        code = request.data.get(self.lookup_url_kwarg)
        if code is not None:
            team_result = Team.objects.filter(code=code)
            if len(team_result) > 0:
                team = team_result[0]
                team.delete()
                return Response({'Successfully deleted team': f'{code}'}, status=HTTP_200_OK)
            return Response({'Not Found': 'Team does not exist'}, status=HTTP_404_NOT_FOUND)

        return Response({'Bad Request': 'Invalid code'}, status=HTTP_400_BAD_REQUEST)


class JoinTeamView(APIView):
    lookup_url_kwarg = 'code'
    permission_classes = [
        permissions.IsAuthenticated
    ]

    def post(self, request, format=None):
        if not self.request.session.exists(self.request.session.session_key):
            self.request.session.create()

        code = request.data.get(self.lookup_url_kwarg)
        if code is not None:
            team_result = Team.objects.filter(code=code)
            if len(team_result) > 0:
                team = team_result[0]
                if request.user.email in team.members:
                    return Response({'Bad Request': 'User already in team'}, status=HTTP_400_BAD_REQUEST)

                self.request.session['team_code'] = code
                usr_email = str(request.user.email)
                team.members += f'{usr_email}, '
                team.save(update_fields=['members'])
                return Response({'Joined team': f'{code}'}, status=HTTP_200_OK)
            return Response({'Not Found': 'Team does not exist'}, status=HTTP_404_NOT_FOUND)

        return Response({'Bad Request': 'Invalid code'}, status=HTTP_400_BAD_REQUEST)


class GetTeamView(APIView):
    serializer_class = TeamSerializer
    lookup_url_kwarg = 'code'
    permission_classes = [
        permissions.IsAuthenticated,
    ]

    def get(self, request, format=None):
        code = request.GET.get(self.lookup_url_kwarg)
        if code is not None:
            room = Team.objects.filter(code=code)
            if len(room) > 0:
                data = TeamSerializer(room[0]).data
                return Response(data, status=HTTP_200_OK)
            return Response({'Team not found': 'Invalid code'}, status=HTTP_404_NOT_FOUND)

        return Response({'Bad Request': 'Code parameter not found in request'}, status=HTTP_400_BAD_REQUEST)
