CREATE VIEW course_list AS
       SELECT c_crn,
              c_coursenumber,
              c_coursetitle,
              c_coursetype,
              c_coursedays,
              c_units,
              ccr_bldgrm,
              c_coursestartend,
              c_coursetime,
              ci_instructorname
         FROM courses, 
              course_classroom, 
              course_instructor
        WHERE c_crn = ccr_crn 
              AND
              c_crn = ci_crn;
