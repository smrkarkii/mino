# Generated by Django 4.1.7 on 2023-02-27 14:26

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0009_user_email'),
    ]

    operations = [
        migrations.DeleteModel(
            name='User',
        ),
    ]
