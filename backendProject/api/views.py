from django.shortcuts import render
from .serializers import routeSerializer, UserSerializer, NotificationSerializer, ExplorePlacesSerializer, VehicleTypeSerializer
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from .models import User
from rest_framework.response import Response
from .models import Route, Notification, ExplorePlaces, VehicleType
from rest_framework import status
from rest_framework.decorators import api_view
# from django.contrib.auth.views import LoginView, LogoutView

# Create your views here.


class RouteList(ListAPIView):
    queryset = Route.objects.all()
    serializer_class = routeSerializer
    
class NotificationList(APIView):
    def get(self, format = None):
        notifications = Notification.objects.all()
        serializer = NotificationSerializer(notifications, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = NotificationSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
class ExplorePlacesList(APIView):
    def get(self, format = None):
        places = ExplorePlaces.objects.all()
        serializer = ExplorePlacesSerializer(places, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = ExplorePlacesSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class VehicleTypeList(APIView):
    def get(self, format = None):
        vehicles = VehicleType.objects.all()
        serializer = VehicleTypeSerializer(vehicles, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = VehicleTypeSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
class UserRecordView(APIView):
    def get(self, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)


    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )

