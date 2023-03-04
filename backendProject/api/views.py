from django.shortcuts import render
from .serializers import  NotificationSerializer, ExplorePlacesSerializer, VehicleTypeSerializer, RegisterSerializer, LoginSerializer, publicRoutesSerializer, DriverSerializer
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from .models import Driver
from rest_framework import permissions
from rest_framework.response import Response
from .models import publicRoutes, Notification, ExplorePlaces, VehicleType
from rest_framework import status,  generics, permissions
from knox.models import AuthToken
from rest_framework.decorators import api_view
from django.contrib.auth import login
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.views import LoginView as KnoxLoginView
# from django.contrib.auth.views import LoginView, LogoutView

# Create your views here.




class publicRoutesList(APIView):
    def get(self, format = None):
        routes = Route.objects.all()
        serializer = publicRoutesSerializer(routes, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = publicRoutesSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
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
    
    
class DriverView(APIView):
    def get(self, format=None):
        drivers = Driver.objects.all()
        serializer = DriverSerializer(drivers, many=True)
        return Response(serializer.data)


    def post(self, request):
        serializer = DriverSerializer(data=request.data)
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


# Register API
class SignupApi(generics.GenericAPIView):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        driver = serializer.save()
        return Response({
            "driver": DriverSerializer(driver, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(driver)[1]
        })


class LoginApi(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        driver = serializer.validated_data
        return Response({
            "driver": DriverSerializer(driver, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(driver)[1]
        })