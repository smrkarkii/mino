from rest_framework import serializers
from .models import publicRoutes, Driver, Notification, ExplorePlaces, VehicleType
from django.contrib.auth.models import User
from django.contrib.auth import authenticate

class publicRoutesSerializer(serializers.ModelSerializer):
    class Meta:
        model = publicRoutes
        fields = ['route_id','starting_point', 'final_point',
                  'stops'
                  ,'fare']

#user serializer
class DriverSerializer(serializers.ModelSerializer):
    class Meta:
        model = Driver
        fields = (
            'user_id','username','email', 'route_id','password','type' 
            
        )
class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Driver
        fields = (
        'user_id','username','email','password'
        
            
        )
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        driver = driver.objects.create_user(validated_data['username'], validated_data['email'], validated_data['password'])

        return driver


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        driver = authenticate(**data)
        if driver and driver.is_active:
            return driver
        raise serializers.ValidationError('Incorrect Credentials Passed.')

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