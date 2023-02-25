from django.contrib import admin
from .models import Route, User, Notification, ExplorePlaces, VehicleType

# Register your models here.
admin.site.register(Route)
admin.site.register(User)
admin.site.register(Notification)
admin.site.register(ExplorePlaces)
admin.site.register(VehicleType)