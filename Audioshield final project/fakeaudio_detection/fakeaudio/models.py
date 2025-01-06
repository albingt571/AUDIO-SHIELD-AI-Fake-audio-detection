from django.db import models

# Create your models here.


class login_table(models.Model):
    username=models.CharField(max_length=100)
    password=models.CharField(max_length=30)
    type=models.CharField(max_length=60)

class user_table(models.Model):
    LOGIN=models.ForeignKey(login_table,on_delete=models.CASCADE)
    firstname=models.CharField(max_length=60)
    lastname=models.CharField(max_length=30)
    photo=models.FileField()
    place=models.CharField(max_length=50)
    email=models.CharField(max_length=50)
    phone=models.BigIntegerField()

class feedback_table(models.Model):
    userid=models.ForeignKey(user_table,on_delete=models.CASCADE)
    feedback=models.CharField(max_length=120)
    date=models.DateField()

class complaint_table(models.Model):
    userid = models.ForeignKey(user_table, on_delete=models.CASCADE)
    complaint=models.CharField(max_length=100)
    date=models.DateField()
    reply=models.CharField(max_length=120)

class otp(models.Model):
    userid = models.ForeignKey(user_table, on_delete=models.CASCADE)
    otp=models.CharField(max_length=10)

class audio_table(models.Model):
    LOGIN=models.ForeignKey(login_table,on_delete=models.CASCADE)
    file=models.FileField()
    result=models.CharField(max_length=50)
    date=models.DateField()
    confidence_level=models.FloatField()