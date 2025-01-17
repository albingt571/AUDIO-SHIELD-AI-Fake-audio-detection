# Generated by Django 4.2.7 on 2024-03-28 05:11

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('fakeaudio', '0002_otp'),
    ]

    operations = [
        migrations.CreateModel(
            name='audio_table',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.FileField(upload_to='')),
                ('result', models.CharField(max_length=50)),
                ('date', models.DateField()),
                ('confidence_level', models.FloatField()),
                ('LOGIN', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='fakeaudio.login_table')),
            ],
        ),
    ]
