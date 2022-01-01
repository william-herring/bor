from rest_framework import permissions
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from .models import Team
from rest_framework.status import *
from rest_framework.response import Response

from .serializers import *


class TeamView(ListAPIView):
    queryset = Team.objects.all()
    serializer_class = TeamSerializer


class CreateTeamView(APIView):
    serializer_class = CreateTeamSerializer

    def post(self, request, format=None):
        if not self.request.session.exists(self.request.session.session_key):
            self.request.session.create()

        serializer = self.serializer_class(data=request.data)
        if serializer.is_valid():
            leader = serializer.data.get('leader')
            title = serializer.data.get('title')
            team = Team(leader=leader, title=title)
            team.save()
            self.request.session['team_code'] = team.code
            return Response(TeamSerializer(team).data, status=HTTP_201_CREATED)

        return Response({'Bad request': 'invalid serializer'}, status=HTTP_400_BAD_REQUEST)


class JoinTeamView(APIView):
    lookup_url_kwarg = 'code'

    def post(self, request, format=None):
        if not self.request.session.exists(self.request.session.session_key):
            self.request.session.create()

        code = request.data.get(self.lookup_url_kwarg)
        if code is not None:
            queryset = Team.objects.filter(code=code)
            if len(queryset) > 0:
                team = queryset[0]
                self.request.session['team_code'] = code
                return Response({'Joined team': f'{code}'}, status=HTTP_200_OK)
            return Response({'Team does not exist'}, status=HTTP_400_BAD_REQUEST)

        return Response({'Invalid code'}, status=HTTP_400_BAD_REQUEST)


class GetTeamView(APIView):
    serializer_class = TeamSerializer
    lookup_url_kwarg = 'code'

    def get(self, request, format=None):
        code = request.GET.get(self.lookup_url_kwarg)
        if code is not None:
            room = Team.objects.filter(code=code)
            if len(room) > 0:
                data = TeamSerializer(room[0]).data
                return Response(data, status=HTTP_200_OK)
            return Response({'Team not found': 'Invalid code'}, status=HTTP_404_NOT_FOUND)

        return Response({'Bad request': 'Code parameter not found in request'}, status=HTTP_400_BAD_REQUEST)
