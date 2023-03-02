from django.db import models
import uuid
from django.contrib.auth.models import User
# Create your models here.

class Route(models.Model):
    starting_point = models.CharField( max_length=50)
    final_point = models.CharField( max_length=50)
    checkpoints =  models.CharField(max_length=50)

    def __str__(self):
      return self.final_point


# class User(models.Model):
#     id=models.UUIDField(default=uuid.uuid4, primary_key=True)
#     username = models.CharField( max_length=50)
#     password = models.CharField( max_length=10)
#     email = models.EmailField( max_length=20)
#     # vehicle_number = models.CharField(max_length=50)

#     def __str__(self):
#       return self.username

class Notification(models.Model):
    title = models.CharField( max_length=20)
    message = models.CharField( max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    read = models.BooleanField(default=False)

    def __str__(self):
      return self.title


class ExplorePlaces(models.Model):
    name = models.CharField(max_length=50)
    location = models.CharField(max_length=50)
    picture = models.ImageField(upload_to='./images')
    description = models.CharField( max_length=250)

    def __str__(self):
      return self.name
    
class VehicleType(models.Model):
    name = models.CharField(max_length=50)
    picture = models.ImageField(upload_to='./images')
    description = models.CharField( max_length=250)

    def __str__(self):
      return self.name
    