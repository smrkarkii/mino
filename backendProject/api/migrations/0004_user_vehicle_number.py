# Generated by Django 4.1.7 on 2023-02-25 10:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_notification'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='vehicle_number',
            field=models.CharField(default=1111, max_length=50),
            preserve_default=False,
        ),
    ]