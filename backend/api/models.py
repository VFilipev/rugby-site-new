from django.db import models
from django.utils import timezone


class Season(models.Model):
    """Модель сезона"""
    name = models.CharField(max_length=200, verbose_name="Название сезона")

    class Meta:
        verbose_name = "Сезон"
        verbose_name_plural = "Сезоны"

    def __str__(self):
        return self.name

class Team(models.Model):
    """Модель команды"""
    name = models.CharField(max_length=200, verbose_name="Название команды")

    class Meta:
        verbose_name = "Команда"
        verbose_name_plural = "Команды"

    def __str__(self):
        return self.name


class StaffType(models.Model):
    """Модель типа персонала"""
    name = models.CharField(max_length=100, verbose_name="Название")

    class Meta:
        verbose_name = "Тип персонала"
        verbose_name_plural = "Типы персонала"

    def __str__(self):
        return self.name


class Player(models.Model):
    """Модель игрока"""
    team = models.ForeignKey(Team, on_delete=models.CASCADE, verbose_name="Команда")
    photo = models.ImageField(upload_to='players/', blank=True, null=True, verbose_name="Фото")
    full_name = models.CharField(max_length=200, verbose_name="ФИО")
    staff_type = models.ForeignKey(StaffType, on_delete=models.CASCADE, verbose_name="Тип персонала", null=True, blank=True)
    season = models.ForeignKey(Season, on_delete=models.CASCADE, verbose_name="Сезон", null=True, blank=True)
    is_hidden = models.BooleanField(default=False, verbose_name="Скрыть игрока", null=True, blank=True)
    order = models.PositiveIntegerField(default=0, verbose_name="Порядок")
    class Meta:
        verbose_name = "Игрок"
        verbose_name_plural = "Игроки"
        ordering = ['order']
    def __str__(self):
        return f"{self.full_name} ({self.team.name})"


class MatchCard(models.Model):
    """Модель матча"""
    date = models.DateTimeField(verbose_name="Дата")
    league = models.CharField(max_length=200, verbose_name="Лига")
    venue = models.CharField(max_length=200, verbose_name="Место")
    team_a = models.CharField(max_length=200, verbose_name="Команда А")
    team_b = models.CharField(max_length=200, verbose_name="Команда Б")
    score_team_a = models.PositiveIntegerField(default=0, verbose_name="Счет Команда А")
    score_team_b = models.PositiveIntegerField(default=0, verbose_name="Счет команда Б")
    is_hidden = models.BooleanField(default=False, verbose_name="Скрыть карточку")

    class Meta:
        verbose_name = "Матч"
        verbose_name_plural = "Матчи"
        ordering = ['-date']

    def __str__(self):
        return f"{self.team_a} vs {self.team_b} - {self.date.strftime('%d.%m.%Y')}"


class TournamentCard(models.Model):
    """Модель турнира"""
    date_start = models.DateField(verbose_name="Дата начала", null=True, blank=True)
    date_end = models.DateField(verbose_name="Дата окончания", null=True, blank=True)
    league = models.CharField(max_length=200, verbose_name="Лига")
    venue = models.CharField(max_length=200, verbose_name="Место")
    position = models.PositiveIntegerField(verbose_name="Место в турнирной таблице")
    team = models.CharField(max_length=200, verbose_name="Команда")
    is_hidden = models.BooleanField(default=False, verbose_name="Скрыть карточку")

    class Meta:
        verbose_name = "Турнир"
        verbose_name_plural = "Турниры"
        ordering = ['-date_start']

    def __str__(self):
        return f"{self.team} - {self.position} место ({self.date_start.strftime('%d.%m.%Y')})"


class Event(models.Model):
    """Модель события/новости"""
    title = models.CharField(max_length=300, verbose_name="Заголовок")
    text = models.TextField(verbose_name="Текст")
    date = models.DateField(verbose_name="Дата")
    preview_photo = models.ImageField(upload_to='events/', blank=True, null=True, verbose_name="Фото превью")
    has_photoset = models.BooleanField(default=False, verbose_name="Фотосет")
    show_on_main = models.BooleanField(default=False, verbose_name="Показывать на главной")
    news_url = models.TextField(verbose_name="Ссылка на новость", null=True, blank=True)
    is_hidden = models.BooleanField(default=False, verbose_name="Скрыть новость")

    class Meta:
        verbose_name = "Событие"
        verbose_name_plural = "События"
        ordering = ['-date']

    def __str__(self):
        return self.title


class Sponsor(models.Model):
    """Модель спонсора"""
    name = models.CharField(max_length=200, verbose_name="Название")
    logo = models.ImageField(upload_to='sponsors/', verbose_name="Лого")

    class Meta:
        verbose_name = "Спонсор"
        verbose_name_plural = "Спонсоры"

    def __str__(self):
        return self.name
class School(models.Model):
    """Модель школы"""
    name = models.CharField(max_length=200, verbose_name="Название")
    order = models.PositiveIntegerField(default=0, verbose_name="Порядок")
    class Meta:
        verbose_name = "Школа"
        verbose_name_plural = "Школы"
    def __str__(self):
        return self.name
class SchoolLocation(models.Model):
    """Модель местоположения школы"""
    school = models.ForeignKey(School, on_delete=models.CASCADE, verbose_name="Школа", related_name='location_set')
    info = models.TextField(verbose_name="Информация")
    class Meta:
        verbose_name = "Местоположение школы"
        verbose_name_plural = "Местоположения школы"
    def __str__(self):
        return self.school.name


