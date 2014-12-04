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
			email = row['Email']
			school = school_list[i]
			c.execute("INSERT INTO instructors VALUES ('" + name + "', '" + title + "', '" + email + "')")
			c.execute("INSERT INTO instructor_school VALUES ('" + name + "', '" + school + "')")

#advisors and advisor_school
for i in range(3):
	with open('csvDocs/' + filename_list[i] + 'ADV.csv', 'rb') as csvfile:
		reader = csv.DictReader(csvfile)
		for row in reader:
			name = row['Name']
			title = row['Title']
			email = row['Email']
			school = school_list[i]
			c.execute("INSERT INTO advisors VALUES ('" + name + "', '" + title + "', '" + email + "')")
			c.execute("INSERT INTO advisor_school VALUES ('" + name + "', '" + school + "')")


#courses and course_instructor
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
		#name_part = instructor.split(',')

		c.execute("INSERT INTO courses VALUES ('" + crn + "', '" + c_num + "', '" + c_title + "', '" + c_type + "', '" + c_days + "', '" + units + "', '" + c_startend + "', '" + c_time + "', '" + instructor + "')")
		#print name_part
		


 
conn.commit()
conn.close()
