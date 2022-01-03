from django.urls import path
from .views import *

urlpatterns = [
    path('join-team', JoinTeamView.as_view()),
    path('team', TeamView.as_view()),
    path('create-team', CreateTeamView.as_view()),
    path('get-team', GetTeamView.as_view()),
    path('delete-team', DeleteTeamView.as_view()),
    path('update-team', UpdateTeamView.as_view())
]
