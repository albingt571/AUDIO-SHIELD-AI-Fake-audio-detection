from django.urls import path

from fakeaudio import views

urlpatterns = [
    path('',views.login),
    path('admin_home',views.admin_home),
    path('logincode',views.logincode),
    path('viewuser',views.viewuser),
    path('viewfeedback',views.viewfeedback),
    path('viewcomplaint',views.viewcomplaint),
    path('sendreply',views.sendreply),
    path('reply/<int:id>',views.reply),
    path('blockuser/<int:id>',views.blockuser),
    path('unblockuser/<int:id>',views.unblockuser),
    path('login_code',views.login_code),
    path('snd_complaints/<int:id>', views.snd_complaints),
    path('v_reply/<int:id>', views.v_reply),
    path('v_reply1/<int:id>', views.v_reply1),
    path('snd_feedback', views.snd_feedback),
    path('registration', views.registration),
    path('viewcomplaint_search',views.viewcomplaint_search),
    path('viewfeedback_search',views.viewfeedback_search),
    path('viewuser_search', views.viewuser_search),
    path('forgotpassword1', views.forgotpassword1),
    path('otpverification', views.otpverification),
    path('newpassword', views.newpassword),
    path('logout', views.logout),
    path('and_send_feedback_user', views.and_send_feedback_user),
    path('viewfeed', views.viewfeed),
    path('complaintadd', views.complaintadd),
    path('complaint_view_reply', views.complaint_view_reply),
    path('profile', views.profile),
    path('editeduser', views.editeduser),
    path('audioupload', views.audioupload),
    path('view_audioresult', views.view_audioresult),
    path('clear_history', views.clear_history),
]
