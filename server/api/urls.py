from django.urls import path
from .views import *

urlpatterns = [
    path('join-team', JoinTeamView.as_view()),
    path('team', TeamView.as_view()),
    path('create-team', CreateTeamView.as_view())
]
