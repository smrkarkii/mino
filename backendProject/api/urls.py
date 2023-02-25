from django.urls import path
from api import views



urlpatterns = [
    path('routes', views.RouteList.as_view()),
    path('users', views.UserRecordView.as_view(), name="users"),
    path('notifications', views.NotificationList.as_view(), name="notifications get"),
    path('exploreplaces', views.ExplorePlacesList.as_view(), name="Explore Places"),
    path('vehiclestype', views.VehicleTypeList.as_view(), name="Vehicles")
]
