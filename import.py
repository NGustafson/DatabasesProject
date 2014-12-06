import sqlite3
import csv

# connect to database
conn = sqlite3.connect("UCMerced_Database")
c = conn.cursor()

# add data for...

#schools
with open('csvDocs/Schools.csv', 'rb') as csvfile:
   reader = csv.DictReader(csvfile)
   for row in reader:
      school = row['School']
      c.execute("INSERT INTO schools VALUES ('" + school + "')")

school_list = ['School of Engineering', 'School of Natural Sciences', 'School of Social Sciences, Humanities and Arts']
filename_list = ['ENGR', 'NATSCI', 'SSHA']
building_dict = {'CLSSRM': 'Classroom and Office Building', 'KOLLIG': 'Kolligian Library', 'SCIENG': 'Science and Engineering 1', 'SE2': 'Science and Engineering 2', 'SSB': 'Student Services Building', 'SSM': 'Social Sciences and Management', 'TENAYA': 'Tenaya', 'unlisted': 'unlisted'}


#majors and major_school
for i in range(3):
   with open('csvDocs/' + filename_list[i] + '_MAJ.csv', 'rb') as csvfile:
      reader = csv.DictReader(csvfile)
      for row in reader:
         major = row['Title']
         major_type = row['Type']
         school = school_list[i]
         c.execute("INSERT INTO majors VALUES ('" + major + "', '" + major_type + "')")
         c.execute("INSERT INTO major_school VALUES ('" + major + "', '" + school + "')")

#instructors and instructor_school
for i in range(3):
   with open('csvDocs/' + filename_list[i] + '.csv', 'rb') as csvfile:
      reader = csv.DictReader(csvfile)
      for row in reader:
         name = row['Name']
         title = row['Title']
         email = str(row['Email'])
         school = school_list[i]
         #print name, title, email, school
         try:
            c.execute("INSERT INTO instructors VALUES ('" + name + "', '" + title + "', '" + email + "')")
         except Exception:
            print name, "already in table"

         c.execute("INSERT INTO instructor_school VALUES ('" + name + "', '" + school + "')")

#advisors and advisor_school
for i in range(3):
   with open('csvDocs/' + filename_list[i] + '_ADV.csv', 'rb') as csvfile:
      reader = csv.DictReader(csvfile)
      for row in reader:
         name = row['Name']
         title = row['Title']
         email = row['Email']
         school = school_list[i]
         c.execute("INSERT INTO advisors VALUES ('" + name + "', '" + title + "', '" + email + "')")
         c.execute("INSERT INTO advisor_school VALUES ('" + name + "', '" + school + "')")


#courses, course_instructor, classroom, course_classroom
with open('csvDocs/CourseData.csv', 'rb') as csvfile:
   reader = csv.DictReader(csvfile)
   for row in reader:
      crn = row['CRN']
      c_num = row['Course #']
      c_title = row['Course Title']
      units = row['Units']
      c_type = row['type']
      c_days = row['Days']
      c_time = row['Time']
      c_room = row['Bldg/Rm']
      c_startend = row['Start-End']
      instructor = row['Instructor']
      name_part = instructor.split(',')
      bld_part = c_room.split(' ')

      try:
         c.execute("INSERT INTO courses VALUES ('" + crn + "', '" + c_num + "', '" + c_title + "', '" + c_type + "', '" + c_days + "', '" + units + "', '" + c_startend + "', '" + c_time + "')")

         try:
            c.execute("SELECT DISTINCT(i_instructorname) FROM instructors WHERE (i_instructorname LIKE '%" + name_part[0] + "%' AND i_instructorname LIKE '%" + name_part[1][1:] + "%')")
            temp_str = str(c.fetchone())
            if temp_str == 'None':
               c.execute("INSERT INTO instructors (i_instructorname) VALUES('" + instructor + "')")
               c.execute("INSERT INTO course_instructor VALUES('" + crn + "', '" + instructor + "')")
            else:
               c.execute("INSERT INTO course_instructor VALUES('" + crn + "', '" + temp_str[3:len(temp_str) - 3] + "')")
         except Exception:
            print "SELECT DISTINCT(i_instructorname) FROM instructors WHERE (i_instructorname LIKE '%" + name_part[0] + "%' AND i_instructorname LIKE '%" + name_part[1][1:] + "%')"
      except Exception:
         print "INSERT INTO courses VALUES ('" + crn + "', '" + c_num + "', '" + c_title + "', '" + c_type + "', '" + c_days + "', '" + units + "', '" + c_startend + "', '" + c_time + "')"
         
      c.execute("SELECT DISTINCT(cr_bldgrm) FROM classroom WHERE cr_bldgrm = '" + c_room + "'") 
      temp_str = str(c.fetchone())
      if temp_str == 'None':
         c.execute("INSERT INTO classroom VALUES('" + c_room + "', '" + building_dict[bld_part[0]] + "', '" + bld_part[1] + "')")
         c.execute("INSERT INTO course_classroom VALUES('" + crn + "', '" + c_room + "')")
      else:
         c.execute("INSERT INTO course_classroom VALUES('" + crn + "', '" + c_room + "')")
 
conn.commit()
conn.close()
