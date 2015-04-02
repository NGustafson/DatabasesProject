<%-- 
    Document   : newCourse
    Created on : Dec 7, 2014, 10:04:10 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert Course</title>
    </head>
    <body>
        <form action="courseList.jsp">
            <input type="submit" value="Back" name="back" />
        </form>
        
        <jsp:useBean id="crsbean" class="DataManage.DBQuery" scope="session"/><%    
        %>
        <jsp:useBean id="course" class="DataManage.Course" scope="session"/><%
            String crn = request.getParameter("crn");
            course = crsbean.findCourse(crn);
        %>
        <form action="insertCourse.jsp">
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
                        <td><input name="CrsCRN"/></td>
                    </tr>
                    <tr>
                        <td>Course #</td>
                        <td><input type="text" name="CrsNum"/></td>
                    </tr>
                    <tr>
                        <td>Course Title</td>
                        <td><input type="text" name="CrsTitle"/></td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td><input type="text" name="CrsType"/></td>
                    </tr>
                    <tr>
                        <td>Days</td>
                        <td><input type="text" name="CrsDays"/></td>
                    </tr>
                    <tr>
                        <td>Units</td>
                        <td><input type="text" name="CrsUnits"/></td>
                    </tr>
                    <tr>
                        <td>Bdlg/Rm</td>
                        <td><input type="text" name="CrsBldgRm"/></td>
                    </tr>
                    <tr>
                        <td>Start-End</td>
                        <td><input type="text" name="CrsStartEnd"/></td>
                    </tr>
                    <tr>
                        <td>Time</td>
                        <td><input type="text" name="CrsTime"/></td>
                    </tr>
                    <tr>
                        <td>Instructor</td>
                        <td><input type="text" name="CrsIns"/></td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Insert" name="insert" />
        </form> 
    </body>
</html>
