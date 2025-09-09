from django.contrib import admin
from .models import Season, Team, StaffType, Player, MatchCard, TournamentCard, Event, Sponsor, School, SchoolLocation


@admin.register(Season)
class SeasonAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
    ordering = ('name',)


@admin.register(Team)
class TeamAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
    ordering = ('name',)


@admin.register(StaffType)
class StaffTypeAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
    ordering = ('name',)


@admin.register(Player)
class PlayerAdmin(admin.ModelAdmin):
    list_display = ('full_name', 'team', 'staff_type', 'season', 'is_hidden', 'order')
    list_filter = ('team', 'staff_type', 'season', 'is_hidden', 'order')
    search_fields = ('full_name', 'team__name')
    ordering = ('team', 'order')
    list_select_related = ('team', 'staff_type', 'season')


@admin.register(MatchCard)
class MatchCardAdmin(admin.ModelAdmin):
    list_display = ('team_a', 'team_b', 'date', 'league', 'score_team_a', 'score_team_b', 'is_hidden')
    list_filter = ('league', 'date', 'is_hidden')
    ordering = ('-date',)


@admin.register(TournamentCard)
class TournamentCardAdmin(admin.ModelAdmin):
    list_display = ('team', 'position', 'date_start', 'date_end', 'league', 'is_hidden')
    list_filter = ('league', 'date_start', 'is_hidden')
    ordering = ('-date_start',)


@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    list_display = ('title', 'date', 'show_on_main', 'is_hidden')
    list_filter = ('date', 'show_on_main', 'is_hidden', 'has_photoset')
    search_fields = ('title', 'text')
    ordering = ('-date',)


@admin.register(Sponsor)
class SponsorAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
    ordering = ('name',)


class SchoolLocationInline(admin.TabularInline):
    model = SchoolLocation
    extra = 1
    fields = ('info',)


@admin.register(School)
class SchoolAdmin(admin.ModelAdmin):
    list_display = ('name', 'order')
    search_fields = ('name',)
    ordering = ('order', 'name')
    inlines = [SchoolLocationInline]


@admin.register(SchoolLocation)
class SchoolLocationAdmin(admin.ModelAdmin):
    list_display = ('school', 'info')
    list_filter = ('school',)
    search_fields = ('school__name', 'info')
    ordering = ('school',)
    list_select_related = ('school',)
