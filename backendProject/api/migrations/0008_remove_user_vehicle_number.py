# Generated by Django 4.1.7 on 2023-02-27 13:55

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0007_alter_user_id'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='vehicle_number',
        ),
    ]
