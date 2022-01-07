# Generated by Django 3.2.7 on 2022-01-05 22:05

import api.models
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Team',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(default=api.models.generate_random_code, max_length=8, unique=True)),
                ('leader', models.EmailField(max_length=254)),
                ('members', models.CharField(max_length=800)),
                ('title', models.CharField(max_length=200)),
            ],
        ),
    ]
