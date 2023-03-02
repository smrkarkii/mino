from django.shortcuts import render
from .serializers import routeSerializer, UserSerializer, NotificationSerializer, ExplorePlacesSerializer, VehicleTypeSerializer, RegisterSerializer, LoginSerializer
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from .models import User
from rest_framework import permissions
from rest_framework.response import Response
from .models import Route, Notification, ExplorePlaces, VehicleType
from rest_framework import status,  generics, permissions
from knox.models import AuthToken
from rest_framework.decorators import api_view
from django.contrib.auth import login
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.views import LoginView as KnoxLoginView
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


# Register API
class SignupApi(generics.GenericAPIView):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        return Response({
            "user": UserSerializer(user, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(user)[1]
        })


class LoginApi(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data
        return Response({
            "user": UserSerializer(user, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(user)[1]
        })