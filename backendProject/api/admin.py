from django.contrib import admin
from .models import publicRoutes, Driver, Notification, ExplorePlaces, VehicleType

# Register your models here.
admin.site.register(publicRoutes)
admin.site.register(Driver)
admin.site.register(Notification)
admin.site.register(ExplorePlaces)
admin.site.register(VehicleType)