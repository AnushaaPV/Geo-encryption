import os
from flask import *
from werkzeug.utils import secure_filename

from src.dbconnectionnew import *
obj=Flask(__name__)


@obj.route('/login',methods=['post'])
def login():
    print(request.form)
    username=request.form['uname']
    password=request.form['pass']
    qry="select*from `login` where username=%s and `password`=%s"
    val=(username,password)
    s=selectone(qry,val)

    if s is None:
        return jsonify({'task':'invalid'})
    else:
        id=s['lid']
        return jsonify({'task':'valid',"id" : id ,"type" : s['user_type'] })



@obj.route('/View_college_chat',methods=['post'])
def View_college_chat():
    lid=request.form['lid']
    qry="SELECT `college`.`college_name`,`college`.`login_id` FROM `student` JOIN`dept` ON `dept`.`department_id`=`student`.`deptid` JOIN `college` ON `college`.`login_id`=`dept`.`college_id` WHERE `student`.`studentid`=%s"
    res=selectall2(qry,lid)
    print(res)
    return jsonify(res)




@obj.route ('/viewdep',methods=['post'])
def viewdep():
    print(request.form)
    lid=request.form['lid']
    qry="SELECT * FROM `dept` where college_id=%s"
    res = selectall2(qry,lid)
    print(res)
    return jsonify(res)

obj.route ('/viewcourse',method=['post'])
def viewcourse():
    print(request.form)
    lid=request.form['lid']
    qry="SELECT `dept`.*,course.*  FROM `dept` JOIN course ON `dept`.department_id=course.departmentid WHERE `dept`.college_id=%s"
    res = selectall2(qry,lid)
    print(res,"zsdsfghjklkjhgfdsfghjkhgfd")
    return jsonify(res)


@obj.route ('/viewqppr',methods=['post'])
def viewqppr():
    print(request.form)
    lid = request.form['lid']
    qry = "SELECT `examschedule`.`examdate`,`examschedule`.`examtime`,`subject`.`subjectname`,`qppr`.`questionppr_name`,`qppr`.`questionppr_id` FROM  `examschedule` JOIN `subject` ON  `subject`.`subjectid`=`examschedule`.`subjectid` JOIN `qppr` ON `qppr`.`exam_id`=`examschedule`.`examscheduleid` JOIN `college` ON `college`.`login_id`=`qppr`.`college_id`  WHERE  `college`.`login_id`=%s"
    res = selectall2(qry, lid)
    print(res)
    return jsonify(res)


@obj.route ('/complaints',methods=['post'])
def complaits():
    lid = request.form['lid']
    complaint=request.form['complaint']
    qry="insert into complaints values(null,%s,curdate(),%s)"
    val = (complaint,lid)
    iud(qry, val)
    return jsonify({'task':'success'})

@obj.route ('/viewcomplaints',methods=['post'])
def viewcomplaints():
    lid = request.form['lid']
    qry="SELECT `complaints`.`complaint`,`reply`.`reply` FROM `reply` JOIN `complaints` ON `complaints`.`comp_id`=`reply`.`compid` WHERE `complaints`.`uid`=%s"

    res = selectall2(qry, lid)
    print(res)
    return jsonify(res)


@obj.route ('/viewsubject',methods=['post'])
def viewsubject():
    print(request.form)
    lid = request.form['lid']
    qry="select `subject`.* ,`course`.*,`dept`.* from `subject` join `course` on `subject`.courseid=`course`.courseid join dept on `course`.departmentid=`dept`.department_id where `dept`.college_id=%s"
    val = lid
    res = selectall2(qry, val)
    print(res)
    return jsonify(res)



@obj.route ('/viewresult',methods=['post'])
def viewresult():
    print(request.form)
    lid = request.form['lid']
    qry="SELECT `student`.*,`test`.* ,`vaccancy`.* ,`result`.*,company.*,dept.* FROM  `company` JOIN `vaccancy` ON `company`.lid=`vaccancy`.cid JOIN `test` ON `vaccancy`.vid=`test`.vid JOIN result ON `test`.tid=`result`.tid JOIN student ON `student`.studentid=`result`.lid  JOIN dept ON `student`.deptid=`dept`.department_id WHERE dept.college_id=%s "
    val = lid
    res = selectall2(qry, val)
    print(res)
    return jsonify(res)





@obj.route ('/viewcourse',methods=['post'])
def viewcourse():
    print(request.form)
    lid=request.form['lid']
    qry="SELECT `dept`.*,course.*  FROM `dept` JOIN course ON `dept`.department_id=course.departmentid WHERE `dept`.college_id=%s"
    res = selectall2(qry,lid)
    print(res)
    return jsonify(res)





#
# @obj.route('/download', methods=['post'])
# def download():
#
#     lid=request.form['staffid']
#     qpid=request.form['gpid']
#     qname=request.form['qpaper']
#     lati=request.form['lat']
#     longt=request.form['longt']
#     print(lati,longt)
#     qry="SELECT `college`.`college_name`,`qppr`.`armstrongno` ,college.`lati`,`college`.`longi`,qppr.college_id,(3959 * ACOS ( COS ( RADIANS(%s) ) * COS( RADIANS( `college`.`lati`) ) * COS( RADIANS( `college`.`longi` ) - RADIANS(%s) ) + SIN ( RADIANS(%s) ) * SIN( RADIANS( `college`.`lati` ) ))) AS user_distance FROM `college` JOIN qppr ON `qppr`.`college_id`=`college`.`login_id`   WHERE  qppr`.`questionppr_id`=%s HAVING user_distance  < 6.2137"
#     val=(lati,longt,lati,lid,qpid)
#     s=selectone(qry,val)
#     print(s)
#     if s is not None:
#         armno=s[1]
#         print(armno)
#         clat=s[2]
#         clongt=s[3]
#         clgid=s[4]
#         key=armno*clat*clongt
#         key = str(key)
#         print(qname)
#         pdata=get_byte_from_file('static/encrypted/'+qname)
#         dt=decrypt(pdata,key)
#         with open('static/decrypted/' +  qname, "wb") as file:
#             file.write(base64.b64decode(dt))
#         return jsonify({'task':  'static/decrypted/' +  qname})
#
#     else:
#         return jsonify({'task': "no value"})
#
# def get_byte_from_file(filename):
#     return open(filename,"rb").read()
#






@obj.route ('/managestudent',methods=['post'])
def managestudent():
    print(request.form)
    lid=request.form['lid']
    qry="SELECT student.*,`dept`.* FROM  student JOIN dept ON student.deptid=dept.department_id WHERE dept.college_id=%s"
    res=selectall2(qry,lid)
    print(res)
    return jsonify(res)

@obj.route ('/viewstudent',methods=['post'])
def viewstudent():


    return jsonify()

@obj.route('/uploadstudent', methods=['post'])
def uploadstudent():
    try:
        print(request.form,request.files)
        fname = request.form['fname']
        lname = request.form['lname']
        reg = request.form['regno']
        grad = request.form['gr']
        dept = request.form['dept']
        gender=request.form['gender']
        month = request.form['m']
        year = request.form['y']
        mm=month+"-"+year
        file = request.files['file']
        username=request.form['uname']
        passwd=request.form['passwd']
        filename =secure_filename(file.filename)
        file.save("static/student/" + filename)
        qry="insert into login values(null,%s,%s,'student')"
        va=(username,passwd)
        lid=iud(qry,va)
        qry = "insert into student values(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        val = (str(lid),fname, lname,reg,grad,dept,gender,mm,filename)
        iud(qry, val)
        return jsonify({'task': 'success'})
    except Exception as e:
        return jsonify({'task': 'error'})


@obj.route ('/notes',methods=['post'])
def notes():
    lid=request.form['lid']
    qry="SELECT `notes`.*,`subject`.*,course.*,dept.* FROM `subject` JOIN notes ON `subject`.`subjectid`=`notes`.`subjid` JOIN course ON `subject`.courseid=`course`.courseid JOIN dept ON `course`.departmentid=`dept`.department_id WHERE dept.college_id=%s"
    # val=lid
    res = selectall2(qry,lid)
    print(res)
    return jsonify(res)

@obj.route('/viewnotes', methods=['post'])
def viewnotes():
    qry="Select * from subject"
    res=selectall(qry)
    print(res)
    return jsonify(res)

@obj.route('/uploadnotes', methods=['post'])
def uploadnotes():
    print(request.form,request.files)
    sid = request.form['sid']
    file = request.files['file']
    fname =secure_filename(file.filename)
    file.save("static/notes/" + fname)
    qry = "insert into notes values(null,%s,%s)"
    val = (sid, fname)
    iud(qry, val)
    return jsonify({'task': 'success'})

@obj.route('/verification',methods=['post'])
def verification():
    print(request.form)
    reg = request.form["reg"]
    name = request.form["fname"]
    qry = "SELECT * FROM student WHERE fname=%s  AND regno=%s"
    val = ( name,reg)

    res = selectone(qry, val)
    print(res)

    if res is None:
        return jsonify({'task': 'Invalid'})

    else:
        return jsonify({'task': 'Valid',"sid":res[0]})

# @obj.route('/verification2',methods=['post'])
# def verification2():
#     content=request.form['content']
#     sid=request.form['lid']
#     qry="select public_key from cipher where studentid=%s"
#     publickey =selectone(qry,sid)
#     key = publickey[0]
#     pk = RSA.importKey(key)
#     print('pk--------------', pk)
#     decrypted_msg = rsa.decrypt_message(content, pk)
#     print("decy msg" + str(decrypted_msg))
#     print(type(decrypted_msg))
#     data = str(decrypted_msg.decode('utf-8')).split(',')
#     print(data)
#     qry="select * from student where studentid=%s"
#     res=selectone(qry,data[1])
#     if res is not None:
#         return jsonify({'task': 'Valid','Name':res[1]+" "+res[2],'Regno':res[3],'Mark':data[0]})
#     else:
#         return jsonify({'task': 'InValid'})


# @obj.route('/photoupload', methods=['POST','GET'])
# def photoupload():
#     file=request.files['files']
#     rgno=request.form['sid']
#     filename=str(secure_filename(file.filename))
#     print(file.filename)
#     file.save(os.path.join('static/pics',filename))
#     print(filename)
#     qry="SELECT photo FROM `student` WHERE `studentid`=%s"
#     out=selectone(qry,rgno)
#     if out is not  None:
#         stphoto=out[0]
#         resss=enf(stphoto,filename)
#         if resss=="ok":
#             return jsonify({'task': 'Certificate valid'})
#         else:
#             return jsonify({'task': 'face doesnot matches'})




@obj.route ('/')
def logout():
    return jsonify()


# =======================chat==========================================




@obj.route ('/view_student',methods=['post'])
def view_student():
    lid=request.form['lid']
    qry="SELECT `student`.*,`dept`.* FROM `student` JOIN `dept` ON student.deptid=`dept`.department_id WHERE dept.college_id=%s"
    # val=lid
    res = selectall2(qry,lid)
    print(res)
    return jsonify(res)


# ===========//

# @app.route('/viewfriends',methods=['post'])
# def viewfriends():
#     lid=request.form['uid']
#     print(lid)
#     qry="SELECT `friend_request`.*,`user_registration`.* FROM `user_registration` JOIN `friend_request` ON `friend_request`.`fromid`=`user_registration`.`lid` WHERE `friend_request`.`toid`=%s AND `friend_request`.`status`='accepted' UNION SELECT `friend_request`.*,`user_registration`.* FROM `user_registration` JOIN `friend_request` ON  `friend_request`.`toid`=`user_registration`.`lid` WHERE `friend_request`.`fromid`=%s AND `friend_request`.`status`='accepted'"
#     value=(lid,lid)
#     res = androidselectall(qry,value)
#     return jsonify(res)


@obj.route('/in_message2',methods=['post'])
def in_message():
    print(request.form)
    fromid = request.form['fid']
    print("fromid",fromid)

    toid = request.form['toid']
    print("toid",toid)

    message=request.form['msg']
    print("msg",message)
    qry = "INSERT INTO `chat` VALUES(NULL,%s,%s,%s,CURDATE())"
    value = (fromid, toid, message)
    print("pppppppppppppppppp")
    print(value)
    iud(qry, value)
    return jsonify(status='send')

@obj.route('/view_message2',methods=['post'])
def view_message2():
    print("wwwwwwwwwwwwwwww")
    print(request.form)
    fromid=request.form['fid']
    print(fromid)
    toid=request.form['toid']
    print(toid)
    lmid = request.form['lastmsgid']
    print("msgggggggggggggggggggggg"+lmid)
    sen_res = []
    # qry="SELECT * FROM chat WHERE (fromid=%s AND toid=%s) OR (fromid=%s AND toid=%s) ORDER BY DATE ASC"
    qry="SELECT `fromid`,`msg`,`date`,`chatid` FROM `chat` WHERE `chatid`>%s AND ((`toid`=%s AND  `fromid`=%s) OR (`toid`=%s AND `fromid`=%s)  )  ORDER BY chatid ASC"
    print("SELECT `fromid`,`msg`,`date`,`chatid` FROM `chat` WHERE `chatid`>%s AND ((`toid`=%s AND  `fromid`=%s) OR (`toid`=%s AND `fromid`=%s)  )  ORDER BY chatid ASC")
    val=(str(lmid),str(toid),str(fromid),str(fromid),str(toid))
    print("fffffffffffff",val)
    res = selectall2(qry,val)
    print("resullllllllllll")
    print(res)
    if res is not None:
        return jsonify(status='ok', res1=res)
    else:
        return jsonify(status='not found')




@obj.route ('/viewcollege',methods=['post'])
def viewcollege():
    lid=request.form['lid']
    qry="SELECT `student`.*,`dept`.*,college.* FROM `student` JOIN `dept` ON student.deptid=`dept`.department_id  join college on dept.college_id=college.login_id WHERE student.studentid=%s"
    # val=lid
    res = selectall2(qry,lid)
    print(res)
    return jsonify(res)

@obj.route ('/viewvaccancy',methods=['post'])
def viewvaccancy():
    lid=request.form['cid']
    qry="SELECT * FROM `vaccancy` WHERE cid=%s"
    res = selectall2(qry,lid)
    print(res)
    return jsonify(res)

@obj.route ('/viewcompany',methods=['post'])
def viewcompany():
    qry="SELECT * FROM `company`"
    res = selectall(qry)
    print(res)
    return jsonify(res)





@obj.route ('/viewnote',methods=['post'])
def viewnote():
    print(request.form)
    lid = request.form['lid']
    qry = "SELECT `notes`.* ,`subject`.*,`student`.* ,`course`.*,`dept`.* FROM notes JOIN `subject` ON `notes`.subjid=`subject`.subjectid JOIN `course` ON `subject`.courseid=`course`.`courseid` JOIN dept ON `course`.`departmentid`=`dept`.`department_id` JOIN student ON dept.`department_id`=`student`.deptid WHERE student.studentid=%s"
    res = selectall2(qry, lid)
    print(res)
    return jsonify(res)



@obj.route ('/viewnotess',methods=['post'])
def viewnotess():
    print(request.form)
    lid = request.form['lid']
    sid = request.form['sid']
    qry = "SELECT `notes`.* ,`subject`.*,`student`.* ,`course`.*,`dept`.* FROM notes JOIN `subject` ON `notes`.subjid=`subject`.subjectid JOIN `course` ON `subject`.courseid=`course`.`courseid` JOIN dept ON `course`.`departmentid`=`dept`.`department_id` JOIN student ON dept.`department_id`=`student`.deptid WHERE student.studentid=%s and notes.subjid=%s"
    val=(lid,sid)
    res = selectall2(qry,val)
    print(res)
    return jsonify(res)

# attend test =============================================================

@obj.route('/get_question', methods=['post'])
def get_question():
    tid=request.form['tid']
    qry = "SELECT `question`.*,`test`.* ,`request`.*,`vaccancy`.*  FROM `vaccancy` JOIN `request` ON `vaccancy`.vid=`request`.jid JOIN `test` ON`vaccancy`.vid=`test`.vid JOIN question ON `question`.tid=`test`.tid WHERE `request`.status='Accepted' and test.tid=%s"
    s = selectall2(qry,tid)
    print(s)
    return jsonify(s)

@obj.route('/Attent_test', methods=['post'])
def Attent_test():
    uid=request.form['lid']
    qid=request.form['qid']
    answer=request.form['answer']
    qry="insert into answer values (null,%s,%s,%s)"
    val=(qid,uid,answer)
    iud(qry,val)
    return jsonify({'task': 'success'})


# =========================================================================


@obj.route('/viewreq', methods=['post'])
def viewreq():
    lid=request.form['lid']
    qry = "SELECT `test`.* ,`request`.*,`vaccancy`.* ,company.name FROM `vaccancy` JOIN `request` ON `vaccancy`.vid=`request`.jid JOIN `test` ON`vaccancy`.vid=`test`.vid  JOIN company ON `company`.lid=`vaccancy`.cid WHERE `request`.status='Accepted' AND `request`.lid=%s"
    s = selectall2(qry,lid)
    print(s)
    return jsonify(s)


@obj.route('/result', methods=['post'])
def result1():
    tid = request.form['tid']
    lid=request.form['lid']
    result=request.form['result']

    qry="insert into result values (null,%s,%s,%s,curdate())"
    val=(tid,lid,result)
    iud(qry,val)

    return jsonify(task="valid")





@obj.route('/sendreq', methods=['post'])
def sendreq():
    uid=request.form['lid']
    qid=request.form['vid']
    qry="insert into request values (null,%s,%s,'pending')"
    val=(qid,uid)
    iud(qry,val)
    return jsonify({'task': 'success'})

@obj.route('/viewresults', methods=['post'])
def viewresults():
    lid=request.form['lid']
    qry = "SELECT * FROM `result` JOIN `test` ON result.tid=test.tid JOIN `vaccancy` ON `test`.vid=`vaccancy`.vid JOIN `company` ON `vaccancy`.cid=`company`.lid WHERE `result`.lid=%s"
    s = selectall2(qry,lid)
    print(s)
    return jsonify(s)







@obj.route('/collegereg1',methods=['post'])
def collegereg1():
    try:
        print(request.form)
        collname=request.form['name']
        place=request.form['place']
        latitude = request.form['latitude']
        longitude = request.form['longitude']
        address = request.form['address']
        phone = request.form['phone']
        uname = request.form['username']
        password = request.form['password']


        qry="insert into login values(null,%s,%s,'pending')"
        val=(uname,password)
        lid=iud(qry,val)
        qry="insert into college values(null,%s,%s,%s,%s,%s,%s,%s)"
        val=(str(lid),collname,place,address,phone,1,1)
        iud(qry,val)
        return jsonify({'task': 'success'})
    except:
        return jsonify({'task': 'failed'})


#
# @app.route('/addlocation', methods=['post'])
# def addlocation():
#     lid=request.form['lid']
#     lat=request.form['lat']
#     lon=request.form['lon']
#     qry="SELECT * FROM `college` WHERE `login_id`=%s"
#     res=selectone(qry,lid)
#     if res is None:
#         qry="INSERT INTO `college` VALUES(NULL,%s,%s,%s)"
#         val=(lid,lat,lon)
#         iud(qry,val)
#     else:
#         qry="UPDATE `location` SET `latitude`=%s,`longitude`=%s WHERE `lid`=%s"
#         val=(lat,lon,lid)
#         iud(qry,val)
#     return jsonify({'task': 'valid'})










obj.run(host='0.0.0.0',port=5000)




