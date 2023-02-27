from rest_framework import serializers
from .models import Route, User, Notification, ExplorePlaces, VehicleType
from django.contrib.auth.models import User
from django.contrib.auth import authenticate

class routeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Route
        fields = ['starting_point', 'final_point', 'checkpoints']

#user serializer
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            'id','username','email'
            
        )
class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
          'id','username','email','password'
        
            
        )
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(validated_data['username'], validated_data['email'], validated_data['password'])

        return user


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        user = authenticate(**data)
        if user and user.is_active:
            return user
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