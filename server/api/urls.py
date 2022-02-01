from django.urls import path
from .views import *

urlpatterns = [
    path('join-team', JoinTeamView.as_view()),
    path('create-team', CreateTeamView.as_view()),
    path('get-team', GetTeamView.as_view()),
    path('update-team', UpdateTeamView.as_view()),
    path('user', UserView.as_view()),
    path('create-user', CreateUserView.as_view()),
    path('get-username', GetUsernameView.as_view()),
    path('get-user-teams', GetUserTeams.as_view()),
    path('send-invite', SendInviteView().as_view()),
    path('get-invites', GetInvitesView().as_view()),
    path('create-project', CreateProjectView().as_view()),
    path('get-projects', GetProjectsView().as_view())
]
