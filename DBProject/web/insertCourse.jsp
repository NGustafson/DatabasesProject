<%-- 
    Document   : insertCourse
    Created on : Dec 7, 2014, 10:47:45 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>INSERT</title>
    </head>
    <jsp:useBean id="updbean" class="DataManage.DBQuery" scope="session"/><%
        
        String crn = request.getParameter("CrsCRN");
        if (!updbean.courseExist(crn)) {
            String crsNum = request.getParameter("CrsNum");
            String title = request.getParameter("CrsTitle");
            String type = request.getParameter("CrsType");
            String days = request.getParameter("CrsDays");
            Integer units;
            if (request.getParameter("crsUnits") == null) {
                units = 0;
            } else {
                units = new Integer(request.getParameter("CrsUnits"));
            }
            String bldgrm = request.getParameter("CrsBldgRm");
            String startend = request.getParameter("CrsStartEnd");
            String time = request.getParameter("CrsTime");
            String ins = request.getParameter("CrsIns");

            updbean.insertCourse(crn, crsNum, title, type, days, units, bldgrm, startend, time, ins);
            out.println("Insert Successful");
            out.println("<form action=\"courseList.jsp\">" +
                "<input type=\"submit\" value=\"Back to Course List\" name=\"back\" />" + 
                "</form>");
        } else {
            out.println("Could not insert.  CRN already Exists");
            out.println("<form action=\"courseList.jsp\">" +
                "<input type=\"submit\" value=\"Back to Course List\" name=\"back\" />" + 
                "</form>");
        }
    %>
    
    
</html>
