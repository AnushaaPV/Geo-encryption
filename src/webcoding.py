import base64

from flask import *
from werkzeug.utils import secure_filename
# from src import rsa
# from src.AESCLASS import *
import pyqrcode
from src.dbconnectionnew import *
obj=Flask(__name__)
obj.secret_key='aaa'

@obj.route('/')
def main():
    return render_template("login_index.html")

@obj.route('/login',methods=['post'])
def login():
    uname=request.form["textfield"]
    password=request.form["textfield2"]
    qry="select * from login where username=%s and password=%s"
    val=(uname,password)
    res=selectone(qry,val)
    if res is None:
        return'''<script>alert('Invalid');window.location='/'</script>'''
    elif res['user_type']=='admin':
        return redirect ('/adminhome')

    elif res['user_type']=='company':
        session['lid'] =res['lid']
        return redirect ('/companyhome')

    else:
        return '''<script>alert('Invalid');window.location='/'</script>'''

#===================================================ADMIN=============================================================

@obj.route('/adminhome')
def adminhome():
    return(render_template("adminindex.html"))


@obj.route('/adddept')
def adddept():
    qry="select * from college"
    res=selectall(qry)
    return(render_template("adddept.html",data=res))

@obj.route('/insert_dept',methods=['post'])
def insert_dept():
    cid=request.form['COLLEGES']
    dept=request.form['dept']
    qry="INSERT INTO `dept` VALUES(NULL,%s,%s)"
    val=(dept,cid)
    iud(qry,val)
    return '''<script>alert("Inserted Successfully");window.location='/adminhome'</script>'''


@obj.route('/addcourse', methods=['POST'])
def addcourse():
    qry="Select * from dept"
    res=selectall(qry)
    return(render_template("addcourse.html",data=res))


@obj.route('/insertcourse', methods=['POST'])
def insertcourse():
    did=request.form['select']
    crs=request.form['textfield']
    qry="INSERT INTO `course` VALUES(NULL,%s,%s)"
    val=(crs,did)
    iud(qry,val)
    return '''<script>alert("Inserted Successfully");window.location='/adminhome'</script>'''

@obj.route('/managecourse')
def managecourse():
    qry="select dept.department_name,course.coursename,`course`.`courseid` from course JOIN dept ON course.departmentid=dept.`department_id`"
    res=selectall(qry)
    print('course',res)
    return (render_template("mange_course.html",data=res))


@obj.route('/editcourse')
def editcourse():
    courseid=request.args.get('id')
    session['courseid']=courseid
    qry="select * from course where courseid=%s"
    res=selectone(qry,session['courseid'])
    qry="SELECT * FROM `dept`"
    res1=selectall(qry)
    print(res1)
    print(res)
    return render_template("editcourse.html",data=res,data1=res1)

@obj.route('/updatecourse',methods=['post'])
def updatecourse():
    department=request.form['dept']
    course=request.form['textfield']
    qry="UPDATE `course` SET `coursename`=%s,`departmentid`=%s WHERE `courseid`=%s"
    val=(course,department,session['courseid'])
    iud(qry,val)
    return '''<script>alert("Updated Successfully");window.location='/managecourse'</script>'''

@obj.route('/deletecourse')
def deletecourse():
    cid=request.args.get('id')
    qry="delete from course where courseid=%s"
    iud(qry,cid)
    return '''<script>alert("Deleted Successfully");window.location='/managecourse'</script>'''

@obj.route('/approvecllgs')
def approvecllgs():
    qry="SELECT `college`.* FROM `college` JOIN `login` ON `login`.`lid`=`college`.`login_id` WHERE `login`.`user_type`='pending'"
    res=selectall(qry)
    print(res)
    return(render_template("approvecllgs.html",data=res))

@obj.route('/acceptcollege')
def acceptcollege():
    lid=request.args.get("id")
    qry="UPDATE `login` SET `user_type`='college' WHERE `lid`=%s"
    val=(lid)
    iud(qry,val)
    return redirect("/approvecllgs")

@obj.route('/view_exam_schedule')
def view_exam_schedule():
    qry = "SELECT `examschedule`.*,`subject`.`subjectname` FROM `examschedule` JOIN `subject` ON `subject`.`subjectid`=`examschedule`.`subjectid`"
    res = selectall(qry)
    return render_template("EXAMSCHEDULES.HTML", data=res)


@obj.route('/addqp')
def addqp():
    id=request.args.get("id")
    session['eid']=id
    return render_template("uploadqppr.html")

@obj.route('/add_qp',methods=['post'])
def add_qp():
    eid=session['eid']
    try:
        exm = eid
        qp = request.files['file']
        fname = secure_filename(qp.filename)
        qp.save('static/question_paper/' + fname)
        qry = "select * from college"
        s = selectall(qry)
        import random
        list = []
        for i in s:
            lati = i['lati']
            longi = i['longi']
            for num in range(100, 10000):
                temp = num
                sum = 0
                while temp > 0:
                    digit = temp % 10
                    sum = sum + digit ** 3
                    temp = temp // 10

                if sum == num:
                    print(num)
                    list.append(num)
            print(list)
            random_num = random.choice(list)
            print(random_num)
            f = open("static/question_paper/" + fname, "rb")
            fileread = f.read()
            key = lati * longi * random_num
            key = str(key)
            pdata = base64.b64encode(fileread)
            print("enc start")
            et = encrypt(pdata.decode('ascii'), key)
            # encrypted_data=encrypt(b64,key)
            with open('static/encrypted/' + str(i['login_id']) + "_" + fname, "wb") as file:
                file.write(et)
            encfile = str(i['login_id']) + "_" + fname
            # dt = decrypt(et, key)
            # print("dt", dt)
            #
            #
            #
            # with open('static/decrypted/' + str(i[0]) + "_" + fname, "wb") as file2:
            #     # file2.write(dec)
            #     file2.write(base64.b64decode(dt))
            # pdata = get_byte_from_file('static/encrypted/' + encfile)
            # dt = decrypt(pdata, key)
            # with open('static/decrypted/' + encfile, "wb") as file:
            #     file.write(base64.b64decode(dt))
            # cmd.execute("insert into question_paper values(null,'" + encfile + "','" + exm + "','" + str(
            #     i[1]) + "','" + str(random_num) + "')")


            qry2 = "INSERT INTO `qppr` VALUES(NULL,%s,%s,%s,%s)"
            val = (encfile, exm, str(i['login_id']), str(random_num))
            iud(qry2, val)
        return '''<script> alert("Registration Success"); window.location="/adminhome"</script>'''
    except Exception as e:
        print("err", e)
        return '''<script> alert("Already added"); window.location="/adminhome"</script>'''




@obj.route('/editschedhule')
def editschedhule():
    id=request.args.get('id')
    session['exid']=id
    qry = "SELECT * FROM `subject`"
    res = selectall(qry)
    qry1="SELECT * FROM examschedule WHERE `examscheduleid`=%s "
    val1=str(id)

    res1=selectone(qry1,val1)
    print(res1)


    return render_template("editexamschedule.html",val1=res1,val=res)





@obj.route('/reply')
def reply():
    id=request.args.get('id')
    session['id']=id
    qry="select * from complaints where comp_id=%s"
    res=selectone(qry,id)
    return (render_template("reply.html",val=res))



@obj.route('/sendreply',methods=['post'])
def sendreply():
    id=session['id']
    reply=request.form['textarea']

    qry="insert into reply values(null,%s,%s)"
    val=(id,reply)
    iud(qry,val)
    return redirect("COMPLAINTS")


@obj.route('/editschedhule1',methods=['post'])
def editschedhule1():
    subject = request.form['select']
    examdate = request.form['textfield']
    examtime = request.form['textfield2']
    qry = " UPDATE `examschedule` SET `examdate`=%s,`examtime`=%s,`subjectid`=%s WHERE `examscheduleid`=%s"
    val = (examdate, examtime, subject,session['exid'])
    print(val)
    iud(qry, val)
    return '''<script>alert("Edited Successfully");window.location='/view_exam_schedule'</script>'''



@obj.route('/deleteexamschedule')
def deleteexamschedule():
    eid=request.args.get('id')
    qry="delete from examschedule where examscheduleid=%s"
    val=str(eid)
    iud(qry,val)
    return '''<script>alert("Deleted Successfully");window.location='/adminhome'</script>'''




@obj.route('/rejectcollege')
def rejectcollege():
    lid=request.args.get("id")
    qry="delete from `login`  WHERE `lid`=%s"
    val=(lid)
    iud(qry,val)
    qry="DELETE FROM `college` WHERE `login_id`=%s"
    iud(qry,val)
    return redirect("/approvecllgs")

@obj.route('/approvedcolleges')
def approvedcolleges():
    qry = "SELECT `college`.* FROM `college` JOIN `login` ON `login`.`lid`=`college`.`login_id` WHERE `login`.`user_type`='college'"
    res = selectall(qry)
    return (render_template("approvedcolleges.html",data=res))



@obj.route('/search_dept',methods=['post'])
def search_dept():
    id=request.form['select']

@obj.route('/certificategen',methods=['get'])
def certificategen():
    qry="select * from college"
    res=selectall(qry)
    return render_template("certificategen.html",data=res)
@obj.route('/insertexamschedule',methods=['post'])
def insertexamschedule():
    subject = request.form['select']
    examdate = request.form['textfield']
    examtime=request.form['textfield2']
    qry = "INSERT INTO `examschedule` VALUES(NULL,%s,%s,%s)"
    val = (examdate,examtime,subject)
    print(val)
    iud(qry, val)
    return '''<script>alert("Inserted Successfully");window.location='/adminhome'</script>'''


@obj.route('/searchcertificate',methods=['post'])
def searchcertificate():
    qry = "SELECT * FROM `college`"
    res1 = selectall(qry)
    id=request.form['select']
    qry="SELECT student.*,dept.* FROM student JOIN `dept` ON `student`.`deptid`=`dept`.`department_id` WHERE `dept`.`college_id`=%s"
    res=selectall2(qry,id)
    print(res)
    return render_template("certificategen.html",val=res,data=res1)


@obj.route('/generate')
def generate():
    id=request.args.get('id')

    session['lid']=id

    qry="SELECT * FROM `student` WHERE `student`.`studentid`=%s"

    res=selectone(qry,id)
    return render_template("generate.html",val=res)


@obj.route('/qr',methods=['POST','GET'])
def qr():

         marks=request.form['select']
         privatekey, publickey = rsa.generate_keys()
         print("pub------"+str(publickey))
         print("prvt---------" + str(privatekey))
         encrypted_msg = rsa.encrypt_message(marks+","+session['lid'], privatekey)
         print(str(encrypted_msg))
         rsa_pvtkey=privatekey.exportKey("PEM")
         print('rsakeyy---------',rsa_pvtkey)
         rsa_pubkey=publickey.exportKey("PEM")
         print('rsapubkeyy---------', rsa_pubkey)
         # rsa_pub = PKCS1_OAEP.new(rsa_pubkey)
         qry="insert into cipher values(null,%s,%s,%s,%s)"
         val=((session['lid']),encrypted_msg,rsa_pvtkey,rsa_pubkey)
         id=iud(qry,val)

         session['cid']=id

         big_code = pyqrcode.create(encrypted_msg, error='L', version=27, mode='binary')
         qrs = "static\\QR\\"+str(id)+".png"
         img_name=str(id)+".png"
         print("imggg--------------" + str(img_name))

         session['qr']=img_name
         big_code.png(qrs, scale=6, module_color=[0, 0, 0, 128], background=[0xff, 0xff, 0xff])
         print('ok')
         # cmd.execute("select student_reg.*,course.Course,student_mark.Description from student_reg  inner join course on  student_reg.Course=course.Course_id inner join login on student_reg.Student_id=login.Uid join student_mark on student_mark.student_id=student_reg.Student_id where student_reg.student_id='"+str(session['id'])+"'")
         qry2="SELECT `college`.`college_name`,`student`.*,`dept`.* FROM `student` JOIN `dept` ON `dept`.`department_id`=`student`.`deptid` JOIN `college` ON `college`.`login_id`=`dept`.`college_id`  WHERE `student`.`studentid`=%s"
         val=session['lid']
         data=selectone(qry2,val)
         print(data)
         print("imggg"+str(img_name))
         return render_template('deploycertificate.html',im=img_name,data=data)


@obj.route('/upcipher',methods=['POST','GET'])
def upcipher():
    id=session['lid']
    qry="SELECT `college`.`college_name`,`student`.*,`dept`.* FROM `student` JOIN `dept` ON `dept`.`department_id`=`student`.`deptid` JOIN `college` ON `college`.`login_id`=`dept`.`college_id`  WHERE `student`.`studentid`=%s"
    s = selectone(qry,id)
    print(s, "certificate")
    return render_template('CERTIFICATE.html', dt=s, im=session['qr'])

@obj.route('/COMPLAINTS')
def COMPLAINTS():
    qry="SELECT `complaints`.*,`college`.* FROM `complaints` JOIN `college` ON `college`.`login_id`=`complaints`.`uid`"
    res=selectall(qry)
    return render_template('COMPLAINTS.HTML',data=res)

@obj.route('/SUBJECT')
def SUBJECT():
    qry="SELECT `subject`.*,`course`.*,`dept`.* FROM `subject` JOIN `course` ON `course`.`courseid`=`subject`.`courseid` JOIN `dept` ON `course`.`departmentid`=`dept`.`department_id`"
    res=selectall(qry)
    return render_template('/SUBJECT.HTML',data=res)

@obj.route('/addsubjects',methods=['post'])
def addsubjects():
    qry="SELECT * FROM `course`"
    res=selectall(qry)
    return render_template('/addsubjects.html',data=res)

@obj.route('/insertsubjects',methods=['post'])
def insertsubjects():
    subjectname=request.form['textfield']
    courseid=request.form['select2']
    qry="INSERT INTO `subject` VALUES (null,%s,%s)"
    val=(subjectname,courseid)
    res=iud(qry,val)
    return '''<script>alert("Added Successfully");window.location='/SUBJECT'</script>'''

@obj.route('/deletesubject')
def deletesubject():
    id = request.args.get('id')
    qry="DELETE FROM `subject` WHERE `subjectid`=(%s)"
    res=iud(qry,id)
    return'''<script>alert("delete successfuly");window.location='/SUBJECT'</script>'''


@obj.route('/addschedhule',methods=['post'])
def addschedhule():
    qry="SELECT * FROM `subject`"
    res=selectall(qry)
    return render_template('/addexamschedule.html',val=res)


# ===================== Company module================

@obj.route('/companyhome',methods=['post','get'])
def companyhome():
    return render_template("companyindex.html")

@obj.route('/mngevaccancy',methods=['get','post'])
def mngevaccancy():
    qry = "SELECT * FROM vaccancy where cid=%s"
    res = selectall2(qry,session['lid'])
    return render_template("mngevcny.html",data=res)

@obj.route('/addv',methods=['get','post'])
def addv():
    return render_template("addvaccancy.html")

@obj.route('/addvaccancy',methods=['post'])
def addvaccancy():
    job = request.form['textfield']
    qualification = request.form['textfield2']
    exp = request.form['textfield4']
    salary=request.form['textfield3']
    qry = "INSERT INTO `vaccancy` VALUES(NULL,%s,%s,%s,%s,%s)"
    val = (job,qualification,exp,salary,session['lid'])
    print(val)
    iud(qry, val)
    return '''<script>alert("Inserted Successfully");window.location='/mngevaccancy'</script>'''

@obj.route('/editv',methods=['get','post'])
def editv():
    id=request.args.get('id')
    session['vid']=id
    qry="SELECT * FROM `vaccancy` WHERE `vid`=%s"
    res=selectone(qry,id)
    print(res)
    return render_template("editvaccancy.html",data=res)

@obj.route('/editvaccancy',methods=['post','get'])
def editvaccancy():
    job = request.form['textfield']
    qualification = request.form['textfield2']
    salary=request.form['textfield3']
    exp = request.form['textfield4']
    qry = "UPDATE `vaccancy` SET `post`=%s,`qualification`=%s,experience=%s,`salary`=%s WHERE `vid`=%s"
    val = (job,qualification,salary,exp,session['vid'])
    print(val)
    iud(qry, val)
    return '''<script>alert("updated Successfully");window.location='/mngevaccancy'</script>'''

@obj.route('/test',methods=['get','post'])
def test():
    q="SELECT  test.*,`vaccancy`.* FROM test JOIN vaccancy ON test.vid=vaccancy.vid WHERE vaccancy.cid=%s"
    re=selectall2(q,session['lid'])
    print(re)
    return render_template("managequesion.html",v=re)

@obj.route('/managequestion',methods=['get','post'])
def managequestion():
    test=request.form['select']
    q="SELECT  test.*,`vaccancy`.* FROM test JOIN vaccancy ON test.vid=vaccancy.vid WHERE vaccancy.cid=%s"
    qry = "SELECT * FROM question where tid=%s"
    res = selectall2(qry,test)
    re=selectall2(q,session['lid'])
    print(res)
    return render_template("managequesion.html",val=res,v=re)

@obj.route('/addq',methods=['get','post'])
def addq():
    qry="SELECT  test.*,`vaccancy`.* FROM test JOIN vaccancy ON test.vid=vaccancy.vid WHERE vaccancy.cid=%s"
    res=selectall2(qry,session['lid'])
    return render_template("addquestion.html",val=res)

@obj.route('/addquestion',methods=['post'])
def addquestion():
    test = request.form['select']
    question = request.form['textfield']
    op1 = request.form['textfield2']
    op2=request.form['textfield3']
    op3 = request.form['textfield4']
    op4 = request.form['textfield5']
    ans=request.form['textfield6']

    qry = "INSERT INTO `question` VALUES(NULL,%s,%s,%s,%s,%s,%s,%s)"
    val = (test,question,op1,op2,op3,op4,ans)
    print(val)
    iud(qry, val)
    return '''<script>alert("Inserted Successfully");window.location='/test'</script>'''

@obj.route('/editquestion',methods=['get','post'])
def editquestion():
    id=request.args.get('id')
    session['qid']=id
    qry="SELECT * FROM `question` WHERE `qid`=%s"
    res=selectone(qry,id)
    q = "SELECT  test.*,`vaccancy`.* FROM test JOIN vaccancy ON test.vid=vaccancy.vid WHERE vaccancy.cid=%s "
    re = selectall2(q, session['lid'])
    print(res)
    return render_template("editques.html",data=res,val=re)

@obj.route('/editqqq',methods=['post','get'])
def editqqq():
    question = request.form['textfield']
    op1 = request.form['textfield2']
    op2 = request.form['textfield3']
    op3 = request.form['textfield4']
    op4 = request.form['textfield5']
    ans = request.form['textfield6']
    qry = " UPDATE `question` SET question=%s,option1=%s,option2=%s,option3=%s,option4=%s,answer=%s WHERE qid=%s"
    val = ( question, op1, op2, op3, op4, ans,session['qid'])
    print(val)
    iud(qry, val)
    return '''<script>alert("UPDATED Successfully");window.location='/test'</script>'''

@obj.route('/deleteqq')
def deleteqq():
    qid=request.args.get('id')
    qry="delete from question where qid=%s"
    iud(qry,qid)
    return '''<script>alert("Deleted Successfully");window.location='/test'</script>'''

@obj.route('/deletev')
def deletev():
    qid=request.args.get('id')
    qry="delete from vaccancy where vid=%s"
    iud(qry,qid)
    return '''<script>alert("Deleted Successfully");window.location='/mngevaccancy'</script>'''

@obj.route('/viewresult',methods=['get','post'])
def viewresult():
    test=request.form['select']
    q="SELECT  test.*,`vaccancy`.* FROM test JOIN vaccancy ON test.vid=vaccancy.vid WHERE vaccancy.cid=%s"
    qry = "SELECT `student`.*,`test`.*,`result`.* FROM `student` JOIN `result` ON student.`studentid`=`result`.lid JOIN test ON result.tid=test.tid WHERE test.tid=%s"
    res = selectall2(qry,test)
    re=selectall2(q,session['lid'])
    print(res)
    return render_template("viewresult.html",val=res,v=re)

@obj.route('/test2',methods=['get','post'])
def test2():
    q="SELECT  test.*,`vaccancy`.* FROM test JOIN vaccancy ON test.vid=vaccancy.vid WHERE vaccancy.cid=%s"
    re=selectall2(q,session['lid'])
    print(re)
    return render_template("viewresult.html",v=re)

@obj.route('/viewapplication',methods=['get','post'])
def viewapplication():
    q="SELECT `request`.*,`vaccancy`.*,student.* FROM vaccancy JOIN request ON  `vaccancy`.vid=`request`.jid JOIN student ON request.lid=student.`studentid` WHERE vaccancy.cid=%s AND `request`.status='pending'"
    re=selectall2(q,session['lid'])
    print(re)
    return render_template("viewreq.html",v=re)

@obj.route('/acceptreq')
def acceptreq():
    lid=request.args.get("id")
    qry="UPDATE `request` SET `status`='Accepted' WHERE `reid`=%s"
    val=(lid)
    iud(qry,val)
    return '''<script>alert("Accepted Successfully");window.location='/viewapplication'</script>'''

@obj.route('/rejectreq')
def rejectreq():
    lid=request.args.get("id")
    qry="UPDATE `request` SET `status`='Rejected' WHERE `reid`=%s"
    val=(lid)
    iud(qry,val)
    return '''<script>alert("Rejected Successfully");window.location='/viewapplication'</script>'''

@obj.route('/managetest',methods=['get','post'])
def managetest():
    q="SELECT * FROM  vaccancy  WHERE cid=%s"
    re=selectall2(q,session['lid'])
    print(re)
    return render_template("managetest.html",v=re)

@obj.route('/manage_test',methods=['get','post'])
def manage_test():
    test=request.form['select']
    q="SELECT * FROM  vaccancy  WHERE cid=%s"
    qry = "SELECT * FROM `test` where vid=%s"
    res = selectall2(qry,test)
    re=selectall2(q,session['lid'])
    print(res)
    return render_template("managetest.html",val=res,v=re)

@obj.route('/deletetest')
def deletetest():
    lid=request.args.get("id")
    qry="DELETE FROM `test` WHERE `tid`=%s"
    val=(lid)
    iud(qry,val)
    return '''<script>alert("deleted Successfully");window.location='/managetest'</script>'''

@obj.route('/addt',methods=['get','post'])
def addt():
    qry="SELECT  * FROM  vaccancy  WHERE cid=%s"
    res=selectall2(qry,session['lid'])
    return render_template("addtest.html",val=res)

@obj.route('/addtest',methods=['post'])
def addtest():
    job = request.form['select']
    test = request.form['textfield']
    details = request.form['textfield2']

    qry = "INSERT INTO `test` VALUES(NULL,%s,%s,%s)"
    val = (test,details,job)
    print(val)
    iud(qry, val)
    return '''<script>alert("Inserted Successfully");window.location='/managetest'</script>'''

obj.run(debug=True)
