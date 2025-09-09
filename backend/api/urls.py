from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    SeasonViewSet, TeamViewSet, StaffTypeViewSet, PlayerViewSet,
    MatchCardViewSet, TournamentCardViewSet, EventViewSet, SponsorViewSet,
    SchoolViewSet, SchoolLocationViewSet
)

router = DefaultRouter()
router.register(r'seasons', SeasonViewSet)
router.register(r'teams', TeamViewSet)
router.register(r'staff-types', StaffTypeViewSet)
router.register(r'players', PlayerViewSet)
router.register(r'matches', MatchCardViewSet)
router.register(r'tournaments', TournamentCardViewSet)
router.register(r'events', EventViewSet)
router.register(r'sponsors', SponsorViewSet)
router.register(r'schools', SchoolViewSet)
router.register(r'school-locations', SchoolLocationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
