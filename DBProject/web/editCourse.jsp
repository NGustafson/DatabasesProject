<%-- 
    Document   : editCourse
    Created on : Dec 7, 2014, 6:47:02 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Course</title>
    </head>
    <body>
        <h1>Edit Course</h1>
        <form action="courseList.jsp">
            <input type="submit" value="Back" name="back" />
        </form>
        
        <jsp:useBean id="crsbean" class="DataManage.DBQuery" scope="session"/><%    
        %>
        <jsp:useBean id="course" class="DataManage.Course" scope="session"/><%
            String crn = request.getParameter("crn");
            course = crsbean.findCourse(crn);
        %>
        <form action="updateCourse.jsp">
            <table border="1">
                <thead>
                    <tr>
                        <th>Label</th>
                        <th>Value</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>CRN</td>
                        <td><%= course.getCRN()%><input type="hidden" name="CrsCRN" value="<%= course.getCRN()%>" /></td>
                    </tr>
                    <tr>
                        <td>Course #</td>
                        <td><input type="text" name="CrsNum" value="<%= course.getCourseNum()%>" /></td>
                    </tr>
                    <tr>
                        <td>Course Title</td>
                        <td><input type="text" name="CrsTitle" value="<%= course.getCourseTitle()%>" /></td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td><input type="text" name="CrsType" value="<%= course.getType()%>" /></td>
                    </tr>
                    <tr>
                        <td>Days</td>
                        <td><input type="text" name="CrsDays" value="<%= course.getDays()%>" /></td>
                    </tr>
                    <tr>
                        <td>Units</td>
                        <td><input type="text" name="CrsUnits" value="<%= course.getUnits()%>" /></td>
                    </tr>
                    <tr>
                        <td>Bdlg/Rm</td>
                        <td><input type="text" name="CrsBldgRm" value="<%= course.getBldgRm()%>" /></td>
                    </tr>
                    <tr>
                        <td>Start-End</td>
                        <td><input type="text" name="CrsStartEnd" value="<%= course.getStartEnd()%>" /></td>
                    </tr>
                    <tr>
                        <td>Time</td>
                        <td><input type="text" name="CrsTime" value="<%= course.getTime()%>" /></td>
                    </tr>
                    <tr>
                        <td>Instructor</td>
                        <td><input type="text" name="CrsIns" value="<%= course.getInstructor()%>" /></td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Update" name="update" />
        </form>                
    </body>
</html>
