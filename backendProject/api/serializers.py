from rest_framework import serializers
from .models import Route, User, Notification, ExplorePlaces, VehicleType


class routeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Route
        fields = ['starting_point', 'final_point', 'checkpoints']

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            'username',
            'password'
        )
class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = (
            'title',
            'message',
            'created_at',
            'read'
            
            
        )
class ExplorePlacesSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExplorePlaces
        fields = (
            'name',
            'location',
            'picture',
            'description'
            
            
        )
class VehicleTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = VehicleType
        fields = (
            'name',
            'picture',
            'description'
             )