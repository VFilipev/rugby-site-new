from rest_framework import viewsets, filters
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import Season, Team, StaffType, Player, MatchCard, TournamentCard, Event, Sponsor, School, SchoolLocation
from .serializers import (
    SeasonSerializer, TeamSerializer, StaffTypeSerializer, PlayerSerializer,
    MatchCardSerializer, TournamentCardSerializer, EventSerializer, SponsorSerializer,
    SchoolSerializer, SchoolLocationSerializer
)


class SeasonViewSet(viewsets.ModelViewSet):
    queryset = Season.objects.all()
    serializer_class = SeasonSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['name']
    ordering = ['name']


class TeamViewSet(viewsets.ModelViewSet):
    queryset = Team.objects.all()
    serializer_class = TeamSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['name']
    ordering = ['name']


class StaffTypeViewSet(viewsets.ModelViewSet):
    queryset = StaffType.objects.all()
    serializer_class = StaffTypeSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['name']
    ordering = ['name']


class PlayerViewSet(viewsets.ModelViewSet):
    queryset = Player.objects.select_related('team', 'staff_type', 'season')
    serializer_class = PlayerSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['team', 'staff_type', 'season', 'is_hidden']
    search_fields = ['full_name', 'team__name']
    ordering_fields = ['full_name', 'team__name']
    ordering = ['team__name', 'full_name']

    @action(detail=False, methods=['get'])
    def by_team(self, request):
        """Получить игроков по команде"""
        team_id = request.query_params.get('team_id')
        if team_id:
            players = self.queryset.filter(team_id=team_id, is_hidden=False)
            serializer = self.get_serializer(players, many=True)
            return Response(serializer.data)
        return Response([])

    @action(detail=False, methods=['get'])
    def by_season(self, request):
        """Получить игроков по сезону"""
        season_id = request.query_params.get('season_id')
        if season_id:
            players = self.queryset.filter(season_id=season_id, is_hidden=False)
            serializer = self.get_serializer(players, many=True)
            return Response(serializer.data)
        return Response([])


class MatchCardViewSet(viewsets.ModelViewSet):
    queryset = MatchCard.objects.all()
    serializer_class = MatchCardSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['league', 'is_hidden']
    search_fields = ['league', 'venue']
    ordering_fields = ['date', 'league']
    ordering = ['-date']

    @action(detail=False, methods=['get'])
    def upcoming(self, request):
        """Получить предстоящие матчи"""
        from django.utils import timezone
        matches = self.queryset.filter(date__gte=timezone.now(), is_hidden=False)
        serializer = self.get_serializer(matches, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=['get'])
    def recent(self, request):
        """Получить последние матчи"""
        from django.utils import timezone
        matches = self.queryset.filter(date__lt=timezone.now(), is_hidden=False)[:10]
        serializer = self.get_serializer(matches, many=True)
        return Response(serializer.data)


class TournamentCardViewSet(viewsets.ModelViewSet):
    queryset = TournamentCard.objects.all()
    serializer_class = TournamentCardSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['league', 'is_hidden']
    search_fields = ['league', 'venue']
    ordering_fields = ['date_start', 'position', 'league']
    ordering = ['-date_start']

    @action(detail=False, methods=['get'])
    def by_team(self, request):
        """Получить турниры по команде"""
        team_id = request.query_params.get('team_id')
        if team_id:
            tournaments = self.queryset.filter(team=team_id, is_hidden=False)
            serializer = self.get_serializer(tournaments, many=True)
            return Response(serializer.data)
        return Response([])


class EventViewSet(viewsets.ModelViewSet):
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['show_on_main', 'is_hidden', 'has_photoset']
    search_fields = ['title', 'text']
    ordering_fields = ['date', 'title']
    ordering = ['-date']

    @action(detail=False, methods=['get'])
    def main_page(self, request):
        """Получить события для главной страницы"""
        events = self.queryset.filter(show_on_main=True, is_hidden=False)
        serializer = self.get_serializer(events, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=['get'])
    def recent(self, request):
        """Получить последние события"""
        events = self.queryset.filter(is_hidden=False)[:10]
        serializer = self.get_serializer(events, many=True)
        return Response(serializer.data)


class SponsorViewSet(viewsets.ModelViewSet):
    queryset = Sponsor.objects.all()
    serializer_class = SponsorSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['name']
    ordering = ['name']


class SchoolViewSet(viewsets.ModelViewSet):
    queryset = School.objects.prefetch_related('location_set').all()
    serializer_class = SchoolSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['name']
    ordering_fields = ['name', 'order']
    ordering = ['order', 'name']


class SchoolLocationViewSet(viewsets.ModelViewSet):
    queryset = SchoolLocation.objects.select_related('school').all()
    serializer_class = SchoolLocationSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['school']
    search_fields = ['info']
    ordering_fields = ['id']
    ordering = ['id']
