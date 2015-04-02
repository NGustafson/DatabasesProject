package DataManage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


public class DBQuery {
    
    Connection conn;
    Statement stat;
    
    public DBQuery() throws ClassNotFoundException {
        
    }
    
    public void DBConnect() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        
        String hostname = "jdbc:mysql://104.236.166.6:3306/UCMerced_Database";
        String user = "nick";
        String pass = "h3pKqmU66T";
        
        conn = DriverManager.getConnection(hostname, user, pass);
        stat = conn.createStatement();
    }
    
    public ResultSet getInstructors() throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM instructors";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public ResultSet getAllInstructors() throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM instructors WHERE i_instructoremail != 'null'";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public ResultSet getInstructorSchool(String filter) throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT i_instructorname, i_instructortitle, i_instructoremail " +
                "FROM instructors, instructor_school " +
                "WHERE i_instructorname = is_instructorname AND is_schoolname = '" +
                filter + "'";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public ResultSet getMajors() throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM majors";
        rs = stat.executeQuery(sql);        
        return rs;
    }
    
    public ResultSet getMajorSchool(String filter) throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT m_majortitle, m_majortype FROM majors, major_school " +
                "WHERE m_majortitle = ms_majortitle AND " +
                "ms_schoolname = '" + filter + "'";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public ResultSet getCourseList() throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM course_list ORDER BY c_coursenumber ASC";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public ResultSet getCourseFiltered(String filter) throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM course_list " +
                "WHERE c_coursenumber LIKE '%" + filter + "%'";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public Course findCourse(String crn) throws Exception {
        Course tempCrs = new Course();
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM course_list WHERE c_crn = '" + crn + "'";
        rs = stat.executeQuery(sql);
        
        while (rs.next()) {
            tempCrs.setCRN(rs.getString("c_crn"));
            tempCrs.setCourseNum(rs.getString("c_coursenumber"));
            tempCrs.setCourseTitle(rs.getString("c_coursetitle"));
            tempCrs.setType(rs.getString("c_coursetype"));
            tempCrs.setDays(rs.getString("c_coursedays"));
            tempCrs.setUnits(rs.getInt("c_units"));
            tempCrs.setBldgRm(rs.getString("ccr_bldgrm"));
            tempCrs.setStartEnd(rs.getString("c_coursestartend"));
            tempCrs.setTime(rs.getString("c_coursetime"));
            tempCrs.setInstructor(rs.getString("ci_instructorname"));        
        }        
        return tempCrs;
    }
    
    public void updateCourse(String crn, String num, 
            String title, String type, String days,
            int units, String bldgrm, String startend,
            String time, String ins) throws Exception {
        Course oldCourse = findCourse(crn);
        DBConnect();
        StringBuffer columns = new StringBuffer(255);
        String sql;
        ResultSet rs;
        boolean bldgChange = false;
        boolean insChange = false;
        
        if (num != null &&
                !num.equals(oldCourse.getCourseNum())) {
            columns.append("c_coursenumber = '" + num + "'");
        }
        if (title != null &&
                !title.equals(oldCourse.getCourseTitle())) {
            if ( columns.length() > 0 ) {
                columns.append( ", " );
            }
            columns.append("c_coursetitle = '" + title + "'");
        }
        if (type != null &&
                !type.equals(oldCourse.getType())) {
            if ( columns.length() > 0 ) {
                columns.append( ", " );
            }
            columns.append("c_coursetype = '" + type + "'");
        }
        if (days != null &&
                !days.equals(oldCourse.getDays())) {
            if ( columns.length() > 0 ) {
                columns.append( ", " );
            }
            columns.append("c_coursedays = '" + days + "'");
        }
        if (units > 0 &&
                !(units == oldCourse.getUnits())) {
            if ( columns.length() > 0 ) {
                columns.append( ", " );
            }
            columns.append("c_units = '" + units + "'");
        }
        if (bldgrm != null &&
                !bldgrm.equals(oldCourse.getBldgRm())) {
            bldgChange = true;
        }
        if (startend != null &&
                !startend.equals(oldCourse.getStartEnd())) {
            if ( columns.length() > 0 ) {
                columns.append( ", " );
             }
            columns.append("c_coursestartend = '" + startend + "'");
        }
        if (time != null &&
                !startend.equals(oldCourse.getTime())) {
            if ( columns.length() > 0 ) {
                columns.append( ", " );
            }
            columns.append("c_coursetime = '" + time + "'");
        }
        if (ins != null &&
                !ins.equals(oldCourse.getInstructor())) {
            insChange = true;
        }
        
        if (columns.length() > 0) {   
            sql = "UPDATE courses SET " + columns.toString() +
                    " WHERE c_crn = '" + crn + "'";
            stat.execute(sql);
            System.out.println(sql);
        }
        if (bldgChange) {
            String tempSQL = "SELECT COUNT(*) FROM " +
                    "classroom WHERE cr_bldgrm = '" + bldgrm + "'";
            System.out.println(tempSQL);
            rs = stat.executeQuery(tempSQL);

            int tempNum = 0;
            while (rs.next()) {
                tempNum = rs.getInt(1);
            }
            if (tempNum == 0) {
                tempSQL = "INSERT INTO classroom "
                        + "VALUES('" + bldgrm + "', 'unlisted', 0)";
                System.out.println(tempSQL);
                stat.execute(tempSQL);
            } else {
                tempSQL = "DELETE FROM course_classroom " +
                        "WHERE ccr_crn = '" + crn + "'";
                System.out.println(tempSQL);
                stat.execute(tempSQL);
            }
            tempSQL = "INSERT INTO course_classroom " +
                    "VALUES('" + crn + "', '" + bldgrm + "')";
            System.out.println(tempSQL);
            stat.execute(tempSQL);                       
        }
        if (insChange) {
            String tempSQL = "SELECT COUNT(*) FROM " +
                    "instructors WHERE i_instructorname = '" + ins + "'";
            System.out.println(tempSQL);
            rs = stat.executeQuery(tempSQL);

            int tempNum = 0;
            while (rs.next()) {
                tempNum = rs.getInt(1);
            }
            if (tempNum == 0) {
                tempSQL = "INSERT INTO instructors(i_instructorname) "
                        + "VALUES('" + ins + "')";
                System.out.println(tempSQL);
                stat.execute(tempSQL);
            } else {
                tempSQL = "DELETE FROM course_instructor " +
                        "WHERE ci_crn = '" + crn + "'";
                System.out.println(tempSQL);
                stat.execute(tempSQL);
            }
            tempSQL = "INSERT INTO course_instructor " +
                    "VALUES('" + crn + "', '" + ins + "')";
            System.out.println(tempSQL);
            stat.execute(tempSQL);                       
        }
    }
    
    public void insertCourse(String crn, String num, 
            String title, String type, String days,
            int units, String bldgrm, String startend,
            String time, String ins) throws Exception {
        DBConnect();
        StringBuffer columns = new StringBuffer(255);
        String sql;
        ResultSet rs;
        int tempnum = 0;
        boolean bldgExist = false;
        boolean insExist = false;
        
        // Check instructor
        sql = "SELECT COUNT(*) FROM " +
                    "instructors WHERE i_instructorname = '" + ins + "'";
        System.out.println(sql);
        rs = stat.executeQuery(sql);
        while (rs.next()) {
            tempnum = rs.getInt(1);
        }
        if (tempnum == 0) {
            sql = "INSERT INTO instructors(i_instructorname) "
                        + "VALUES('" + ins + "')";
            System.out.println(sql);
            stat.execute(sql);
        }
        
        // Check bldgrm
        sql = "SELECT COUNT(*) FROM " +
                    "classroom WHERE cr_bldgrm = '" + bldgrm + "'";
        System.out.println(sql);
        rs = stat.executeQuery(sql);
        while (rs.next()) {
            tempnum = rs.getInt(1);
        }
        if (tempnum == 0) {
            sql = "INSERT INTO classroom "
                        + "VALUES('" + bldgrm + "', 'unlisted', 0)";
            System.out.println(sql);
            stat.execute(sql);
        }
        
        //INSERT the rest
        sql = "INSERT INTO courses VALUES('" + crn + "','" +
                num + "','" + title + "','" + type + "','" + 
                days + "'," + units + ",'" + startend +
                "','" + time + "')";
        System.out.println(sql);
        stat.execute(sql);
        
        sql = "INSERT INTO course_instructor " +
                    "VALUES('" + crn + "', '" + ins + "')";
        System.out.println(sql);
        stat.execute(sql);
        
        sql = "INSERT INTO course_classroom " +
                    "VALUES('" + crn + "', '" + bldgrm + "')";
        System.out.println(sql);
        stat.execute(sql);
    }
    
    public boolean courseExist(String crn) throws Exception{
        DBConnect();
        String sql;
        ResultSet rs;
        int tempnum = 0;
        
        sql = "SELECT COUNT(*) FROM courses WHERE "
                + "c_crn = '" + crn + "'";
        rs = stat.executeQuery(sql);
        while (rs.next()) {
            tempnum = rs.getInt(1);
        }
        if (tempnum == 0) return false;
        else return true;
    }
    
    public void deleteCourse(String crn) throws Exception {
        Course oldCourse = findCourse(crn);
        DBConnect();
        String sql;
        
        sql = "DELETE FROM course_instructor WHERE " +
                "ci_crn = '" + crn + "'";
        System.out.println(sql);
        stat.execute(sql);
        
        sql = "DELETE FROM course_classroom WHERE " +
                "ccr_crn = '" + crn + "'";
        System.out.println(sql);
        stat.execute(sql);
        
        sql = "DELETE FROM courses WHERE " +
                "c_crn = '" + crn + "'";
        System.out.println(sql);
        stat.execute(sql);
        
    }
    
    public ResultSet getPrereq() throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM prerequisite";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public ResultSet getPrereqFiltered(String filter) throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM prerequisite " +
                "WHERE p_coursenum LIKE '%" + filter + "%'";
        rs = stat.executeQuery(sql);
        return rs;       
    }
    
    public ResultSet getAdvisors() throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM advisors";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public ResultSet getAdvisorSchool(String school) throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT a_advisorname, a_advises, a_advisoremail FROM advisors, advisor_school " + 
                "WHERE as_advisorname = a_advisorname AND as_schoolname = '" + school + "'";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public ResultSet getSchools() throws Exception {
        ResultSet rs;
        String sql;
        DBConnect();
        
        sql = "SELECT * FROM schools";
        rs = stat.executeQuery(sql);
        return rs;
    }
    
}