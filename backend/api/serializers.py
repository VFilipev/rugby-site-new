from rest_framework import serializers
from .models import Season, Team, StaffType, Player, MatchCard, TournamentCard, Event, Sponsor, School, SchoolLocation


class SeasonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Season
        fields = ['id', 'name']


class TeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Team
        fields = ['id', 'name']


class StaffTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = StaffType
        fields = ['id', 'name']


class PlayerSerializer(serializers.ModelSerializer):
    team_name = serializers.CharField(source='team.name', read_only=True)
    staff_type_name = serializers.CharField(source='staff_type.name', read_only=True)
    season_name = serializers.CharField(source='season.name', read_only=True)
    photo_url = serializers.SerializerMethodField()

    class Meta:
        model = Player
        fields = [
            'id', 'team', 'team_name', 'photo', 'photo_url', 'full_name',
            'staff_type', 'staff_type_name', 'season', 'season_name', 'is_hidden', 'order'
        ]

    def get_photo_url(self, obj):
        if obj.photo:
            request = self.context.get('request')
            if request:
                return request.build_absolute_uri(obj.photo.url)
            return obj.photo.url
        return None


class MatchCardSerializer(serializers.ModelSerializer):
    date_formatted = serializers.DateTimeField(source='date', format='%d.%m.%Y %H:%M', read_only=True)

    class Meta:
        model = MatchCard
        fields = [
            'id', 'date', 'date_formatted', 'league', 'venue',
            'team_a', 'team_b',
            'score_team_a', 'score_team_b', 'is_hidden'
        ]


class TournamentCardSerializer(serializers.ModelSerializer):
    date_formatted = serializers.DateTimeField(source='date', format='%d.%m.%Y %H:%M', read_only=True)

    class Meta:
        model = TournamentCard
        fields = [
            'id', 'date_start', 'date_end', 'date_formatted', 'league', 'venue',
            'position', 'team', 'is_hidden'
        ]


class EventSerializer(serializers.ModelSerializer):
    preview_photo_url = serializers.SerializerMethodField()
    date_formatted = serializers.DateField(source='date', format='%d.%m.%Y', read_only=True)

    class Meta:
        model = Event
        fields = [
            'id', 'title', 'text', 'date', 'date_formatted',
            'preview_photo', 'preview_photo_url', 'has_photoset',
            'show_on_main', 'is_hidden', 'news_url'
        ]

    def get_preview_photo_url(self, obj):
        if obj.preview_photo:
            request = self.context.get('request')
            if request:
                return request.build_absolute_uri(obj.preview_photo.url)
            return obj.preview_photo.url
        return None


class SponsorSerializer(serializers.ModelSerializer):
    logo_url = serializers.SerializerMethodField()

    class Meta:
        model = Sponsor
        fields = ['id', 'name', 'logo', 'logo_url']

    def get_logo_url(self, obj):
        if obj.logo:
            request = self.context.get('request')
            if request:
                return request.build_absolute_uri(obj.logo.url)
            return obj.logo.url
        return None


class SchoolLocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = SchoolLocation
        fields = ['id', 'info']


class SchoolSerializer(serializers.ModelSerializer):
    location_set = SchoolLocationSerializer(many=True, read_only=True)

    class Meta:
        model = School
        fields = ['id', 'name', 'location_set', 'order']
