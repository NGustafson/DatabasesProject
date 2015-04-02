<%-- 
    Document   : updateCourse
    Created on : Dec 7, 2014, 8:11:04 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UPDATE</title>
    </head>
    <jsp:useBean id="updbean" class="DataManage.DBQuery" scope="session"/><%
        String crn = request.getParameter("CrsCRN");
        String crsNum = request.getParameter("CrsNum");
        String title = request.getParameter("CrsTitle");
        String type = request.getParameter("CrsType");
        String days = request.getParameter("CrsDays");
        Integer units = new Integer(request.getParameter("CrsUnits"));
        String bldgrm = request.getParameter("CrsBldgRm");
        String startend = request.getParameter("CrsStartEnd");
        String time = request.getParameter("CrsTune");
        String ins = request.getParameter("CrsIns");
        
        updbean.updateCourse(crn, crsNum, title, type, days, units, bldgrm, startend, time, ins);
    %>
    
    <jsp:forward page="courseList.jsp"></jsp:forward>
</html>
