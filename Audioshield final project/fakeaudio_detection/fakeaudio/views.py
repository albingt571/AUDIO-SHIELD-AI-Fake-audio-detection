import datetime
import smtplib
from email.mime.text import MIMEText
from django.contrib import auth
from .predict import predict_audio
from debugpy.common import json
from django.contrib.auth.decorators import login_required
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse, request
from django.http.response import JsonResponse, HttpResponseNotFound
from django.shortcuts import render

# Create your views here.
from django.views.decorators.csrf import csrf_exempt

from fakeaudio.models import *
import os

def login(request):
    auth.logout(request)
    return render(request,'adminlogin.html')


def logout(request):
    auth.logout(request)
    return render(request,"adminlogin.html")

def logincode(request):
    uname=request.POST['textfield']
    pword=request.POST['textfield2']
    try:
        ob=login_table.objects.get(username=uname,password=pword,type='admin')
        if ob.type=='admin':
            oba = auth.authenticate(username='admin', password='admin')
            if oba is not None:
                auth.login(request, oba)
            return HttpResponse('''<script>alert("SUCCESS");window.location="/admin_home"</script>''')
        else:
            return HttpResponse('''<script>alert("Invalid Username or Password");window.location="/"</script>''')
    except Exception as e:
        print(e)
        return HttpResponse('''<script>alert("Invalid Username or Password");window.location="/"</script>''')

@login_required(login_url='/')
def admin_home(request):
    # return render(request,'admin_home.html')
    return render(request,'adminindex.html')

@login_required(login_url='/')
def viewuser(request):
    ob=user_table.objects.all()
    return render(request,'View user.html',{'val':ob})

@login_required(login_url='/')
def viewuser_search(request):
    name=request.POST['textfield']
    ob = user_table.objects.filter(firstname__istartswith=name)
    return render(request, 'View user.html',{'val':ob,'name':name})

@login_required(login_url='/')
def blockuser(request,id):
    ob=login_table.objects.get(id=id)
    ob.type='block'
    ob.save()
    return HttpResponse('''<script>alert("blocked");window.location="/viewuser"</script>''')

@login_required(login_url='/')
def unblockuser(request,id):
    ob=login_table.objects.get(id=id)
    ob.type='user'
    ob.save()
    return HttpResponse('''<script>alert("unblocked");window.location="/viewuser"</script>''')

@login_required(login_url='/')
def viewfeedback(request):
    ob = feedback_table.objects.all()
    return render(request, 'viewfeedback.html',{'val':ob})

@login_required(login_url='/')
def viewfeedback_search(request):
    date=request.POST['textfield']
    ob = feedback_table.objects.filter(date=date)
    return render(request, 'viewfeedback.html',{'val':ob,'date':date})

@login_required(login_url='/')
def viewcomplaint(request):
    ob = complaint_table.objects.all()
    return render(request,'viewComplaintreplay.html',{'val':ob})

@login_required(login_url='/')
def viewcomplaint_search(request):
    date = request.POST['textfield']
    ob = complaint_table.objects.filter(date=date)
    return render(request,'viewComplaintreplay.html',{'val':ob, 'date':date})

@login_required(login_url='/')
def reply(request,id):
    request.session['cid']=id
    return render(request,'reply.html')

@login_required(login_url='/')
def sendreply(request):
    rep=request.POST['textfield']
    ob=complaint_table.objects.get(id = request.session['cid'])
    ob.reply=rep
    ob.save()
    return HttpResponse('''<script>alert("Reply Send");window.location="/viewcomplaint"</script>''')




"===================android=================="
def login_code(request):
    un = request.POST['uname']
    pw = request.POST['pswrd']
    try:
        users = login_table.objects.get(username = un, password = pw)
        print(users,"+++++++++++++++++++++")
        if users is None:
            data = {"task" : "invalid"}
        else:
            print("=======================")
            if users.type == "user":
                data = {"task" : "valid","lid":users.id,'type':users.type}
            else:
                print("{}{}{}{}{}{}{}{}{}{}{}{}")
                data = {"task" : "block"}
        l = json.dumps(data)
        print(l)
        return HttpResponse(l)
    except Exception as e:
        print(e,"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4")
        data = {"task": "invalid"}
        l = json.dumps(data)
        return HttpResponse(l)

import random
def forgotpassword1(request):
    print(request.POST)
    try:
        print("1")
        print(request.POST)
        email = request.POST['uname']
        print(email)
        ob = user_table.objects.filter(email = email)
        if len(ob)>0:

            try:
                gmail = smtplib.SMTP('smtp.gmail.com', 587)
                gmail.ehlo()
                gmail.starttls()
                gmail.login('email', 'code') ##enter the mail id and code from which you want to send
                print("login=======")
            except Exception as e:
                print("Couldn't setup email!!" + str(e))
            otpp=random.randint(10000,99999)
            obo=otp()
            obo.userid=ob[0]
            obo.otp=otpp
            obo.save()
            msg = MIMEText("Your new password reset otp is : " + str(otpp))
            print(msg)
            msg['Subject'] = 'AudioShield Rest Password'
            msg['To'] = email
            msg['From'] = 'email'    ##your email id

            print("ok====")

            try:
                gmail.send_message(msg)
            except Exception as e:
                return JsonResponse({"task":"invalid"})
            return JsonResponse({"task":"valid"})
        else:
            return JsonResponse({"task":"invalid"})
    except Exception as e:
        print(e)
        return JsonResponse({"task":"invalid"})

def otpverification(request):
    otpp = request.POST['uname']
    print(otpp)
    try:
        ot = otp.objects.get(otp=otpp)
        if ot is None:
            data = {"task": "invalid"}
        else:
            data = {"task": "valid", "lid": ot.userid.LOGIN.id}
        l = json.dumps(data)
        return HttpResponse(l)
    except:
        data = {"task": "invalid"}
        l = json.dumps(data)
        return HttpResponse(l)

def newpassword(request):
    pw = request.POST['pswrd']
    lid = request.POST['lid']
    ob = login_table.objects.get(id=lid)
    ob.password = pw
    print(lid)
    ob.save()
    data = {"task": "ok"}
    l = json.dumps(data)
    print(l)
    return HttpResponse(l)


def snd_complaints(request):
    complaint = request.POST['complaint']
    usr = request.POST['lid']
    cmplnt = complaint_table()

    cmplnt.complaints = complaint
    cmplnt.date =datetime.now()
    cmplnt.reply = 'Pending'
    cmplnt.userid = user_table.objects.get(LOGIN__id=usr)
    cmplnt.save()
    data = {"task": "valid"}
    l = json.dumps(data)
    print(l)
    return HttpResponse(l)

def v_reply(request):
    usr = request.POST['lid']
    ob = complaint_table.objects.filter(userid__LOGIN__id=usr)
    print(ob,"JJJJJJJJJJJJJJJJJJJJJJJJJ")
    data = []
    for i in ob:
        replyy = {"complaint":i.complaint,"rply":i.reply, "dt":str(i.date)}
        data.append(replyy)
    l = json.dumps(data)
    return HttpResponse(l)

def v_reply1(request):
    usr = request.POST['lid']
    dates = request.POST['dater']
    print(dates,"yyyyy")
    ob = complaint_table.objects.filter(userid__LOGIN__id=usr,date=dates)
    data = []
    for i in ob:
        replyy = {"complaint":i.complaint,"rply":i.reply, "dt":str(i.date)}
        data.append(replyy)
    l = json.dumps(data)
    return HttpResponse(l)

def snd_feedback(request):
    feedback = request.POST['feedback']
    usr = request.POST['lid']
    feed = feedback_table()

    feed.complaints = feedback
    feed.date =datetime.datetime.now()
    feed.userid = user_table.objects.get(LOGIN__id=usr)
    feed.save()
    data = {"task": "valid"}
    l = json.dumps(data)
    print(l)
    return HttpResponse(l)

def registration(request):
    fname = request.POST['fname']
    lname = request.POST['lname']
    place = request.POST['place']
    email = request.POST['email']
    phone = request.POST['phone']
    img = request.POST['image']
    import base64

    timestr = datetime.now().strftime("%Y%m%d-%H%M%S")
    print(timestr)
    a = base64.b64decode(img)
    fh = open(r"D:\\fakeaudio_detection\\media\\" + timestr + ".jpg", "wb")
    path = timestr + ".jpg"
    fh.write(a)
    fh.close()
    password = request.POST['password']

    ob=login_table()
    ob.username = email
    ob.password = password
    ob.type = 'user'
    ob.save()
    oj = user_table()
    oj.firstname = fname
    oj.lastname = lname
    oj.place = place
    oj.email = email
    oj.phone = phone
    oj.photo=path
    oj.LOGIN = ob
    oj.save()
    data = {"task": "ok"}
    l = json.dumps(data)
    print(l)
    return HttpResponse(l)

"================================================================"
from datetime import datetime

def and_send_feedback_user(request):
    user_lid = request.POST.get('lid')
    feedback = request.POST.get('feedback')

    try:
        user = user_table.objects.get(LOGIN_id=user_lid)
        ob = feedback_table.objects.create(userid=user, feedback=feedback, date=datetime.today())
        data = {'task': "ok"}
    except Exception as e:
        print("Error:", e)
        data = {'task': "error"}

    return JsonResponse(data)


from django.http import JsonResponse
from .models import feedback_table

def viewfeed(request):
    if request.method == 'POST':
        try:
            lid = request.POST.get('lid')
            if lid is not None:
                feedbacks = feedback_table.objects.filter(userid__LOGIN__id=lid).order_by('-id').values('id', 'feedback', 'date')
                data = {'status': 'ok', 'data': list(feedbacks)}
                return JsonResponse(data)
            else:
                return JsonResponse({'status': 'error', 'message': 'lid parameter missing'}, status=400)
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)
    else:
        return JsonResponse({'status': 'error', 'message': 'Method not allowed'}, status=405)





@csrf_exempt
def and_comp(request):
    if request.method == 'POST':
        user_lid = request.POST.get('lid')
        complaint_text = request.POST.get('complaint')

        try:
            user = user_table.objects.get(LOGIN_id=user_lid)
            complaint = complaint_table.objects.create(userid=user, complaint=complaint_text, date=datetime.today(), reply='')
            data = {'task': "ok"}
            return JsonResponse(data)
        except Exception as e:
            print("Error:", e)
            data = {'task': "error"}
            return JsonResponse(data)


@csrf_exempt
def complaintadd(request):
    if request.method == 'POST':
        lid = request.POST.get('lid')
        complaint_text = request.POST.get('complaint')

        try:
            # Assuming user_id is fetched from lid
            user_id = login_table.objects.get(pk=lid).user_table_set.first().id
            complaint = complaint_table.objects.create(userid_id=user_id, complaint=complaint_text, date=datetime.now(),
                                                       reply='pending')
            data = {'task': "ok"}
        except Exception as e:
            print("Error:", e)
            data = {'task': "error"}

        return JsonResponse(data)


from django.http import JsonResponse
from .models import complaint_table

def complaint_view_reply(request):
    if request.method == 'POST':
        lid = request.POST.get('lid')

        try:
            # Fetch complaints based on user ID (assuming lid corresponds to user ID)
            complaints = complaint_table.objects.filter(userid__LOGIN__id=lid).order_by('-id').values('id', 'date', 'reply', 'complaint')
            data = {'status': 'ok', 'data': list(complaints)}
        except Exception as e:
            print("Error:", e)
            data = {'status': 'error', 'message': str(e)}

        return JsonResponse(data)


def profile(request):
    lid=request.POST['lid']
    # ip=request.POST['ip']
    ob=user_table.objects.get(LOGIN__id=lid)
    data={"fname": ob.firstname,
          'lname':ob.lastname,
                    "place": ob.place,
                    "phone": str(ob.phone),
                    "email": ob.email,
                    "photo": ob.photo.url,
                    "id": ob.id}
    print(data)
    return JsonResponse(data)

def editeduser(request):
    print("{}{}{}{}{}",request.POST,"{}{}{}{}{}")
    id = request.POST['id']
    fname = request.POST['fname']
    lname = request.POST['lname']
    place = request.POST['place']
    email = request.POST['email']
    phone = request.POST['phone']
    img = request.POST['photo']
    if img=="":
        print("++++++++++++++++++++++++++++")
        ob = user_table.objects.get(id=id)
        ob.firstname = fname
        ob.lastname = lname
        ob.place = place
        ob.phone = phone
        ob.email = email
        ob.save()
        data = {'task': "ok"}
        return JsonResponse(data)
    else:
        print("__________________________________")

        import base64
        timestr = datetime.now().strftime("%Y%m%d-%H%M%S")
        print(timestr)
        a = base64.b64decode(img)
        fh = open(r"D:\\fakeaudio_detection\\media\\" + timestr + ".jpg", "wb")
        path = timestr + ".jpg"
        fh.write(a)
        fh.close()
        ob = user_table.objects.get(id=id)
        ob.firstname = fname
        ob.lastname = lname
        ob.place = place
        ob.phone = phone
        ob.email = email
        ob.photo = path
        ob.save()
        data = {'task': "ok"}
        return JsonResponse(data)



def audioupload(request):
    file = request.POST['file']
    lid = request.POST['lid']
    ext = request.POST['type'].split("'")[0]

    print(ext,"ext")
    print(ext,"ext")
    print(ext,"ext")
    print(ext,"ext")

    import base64

    timestr = datetime.now().strftime("%Y%m%d-%H%M%S")
    print(timestr)
    a = base64.b64decode(file)
    fh = open(r"D:\\fakeaudio_detection\\media\\" + timestr + "."+ext, "wb")
    path = timestr + "."+ext
    fh.write(a)
    fh.close()
    if ext!="wav":
        os.system('ffmpeg -i D:\\fakeaudio_detection\\media\\' + path + ' D:\\fakeaudio_detection\\media\\' + timestr + ".wav")
    fpath="D:\\fakeaudio_detection\\media\\" + timestr + ".wav"
    res=predict_audio(fpath)
    print(res,"+=+=+=+=+=+===++++++")
    print(res,"+=+=+=+=+=+===++++++")
    print(res,"+=+=+=+=+=+===++++++")
    print(res,"+=+=+=+=+=+===++++++")
    ob=audio_table()
    ob.file=path
    ob.LOGIN=login_table.objects.get(id=lid)
    ob.date=datetime.now()
    ob.result=res[0]
    c=0
    if res[0]=="Real":
        c=str(round(res[1]*100,2))
        ob.confidence_level=str(round(res[1]*100,2))
    else:
        c=str(100-round(res[1]*100,2))
        ob.confidence_level = str(100-round(res[1] * 100, 2))
    ob.save()
    data = {'task': res[0],"c":str(c)}
    return JsonResponse(data)


from django.http import JsonResponse
from .models import audio_table

def view_audioresult(request):
    if request.method == 'POST':
        try:
            lid = request.POST['lid']
            audio_results = audio_table.objects.filter(LOGIN__id=lid).order_by('-id').values('id', 'result', 'date', 'confidence_level', 'file')
            data = {
                'status': 'ok',
                'data': list(audio_results)
            }
            return JsonResponse(data)
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)
    else:
        return JsonResponse({'status': 'error', 'message': 'Method not allowed'}, status=405)


# Django views.py

from django.http import JsonResponse
from .models import audio_table, complaint_table, feedback_table

def clear_history(request):
    if request.method == 'POST':
        lid = request.POST.get('lid')

        try:
            # Clear history for audio results
            audio_table.objects.filter(LOGIN__id=lid).delete()

            # Clear history for complaints
            complaint_table.objects.filter(userid__LOGIN__id=lid).delete()

            # Clear history for feedback
            feedback_table.objects.filter(userid__LOGIN__id=lid).delete()

            data = {'status': 'ok', 'message': 'History cleared successfully'}
        except Exception as e:
            print("Error:", e)
            data = {'status': 'error', 'message': str(e)}

        return JsonResponse(data)
    else:
        return JsonResponse({'status': 'error', 'message': 'Method not allowed'}, status=405)
