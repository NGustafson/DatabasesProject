<%-- 
    Document   : deleteCourse
    Created on : Dec 7, 2014, 10:04:46 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DELETE</title>
    </head>
    <jsp:useBean id="crsbean" class="DataManage.DBQuery" scope="session"/><%
        String crn = request.getParameter("crn");
        crsbean.deleteCourse(crn);
    %>
    <jsp:forward page="courseList.jsp"></jsp:forward>
</html>
