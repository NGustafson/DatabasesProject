<%-- 
    Document   : prereq
    Created on : Dec 7, 2014, 4:13:57 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Course Prerequisites</title>
    </head>
    <body>
        <h1>Course Prerequisites</h1>
        <form action="courseList.jsp">
            <input type="submit" value="Back" name="back" />
        </form>
        <jsp:useBean id="prebean" class="DataManage.DBQuery" scope="session"/><%
            ResultSet rs;
            String filter = request.getParameter("crsNum");
            if (filter == null || filter.equals("None")) {
                rs = prebean.getPrereq();
            } else {
                rs = prebean.getPrereqFiltered(filter);
            }
        %>
        
        <form action="prereq.jsp">       
            Filter by Course #
            <input type="text" name="crsNum" value="None" size="20" />
            
            <input type="submit" value="Submit" name="filter" />
        </form>
        
        <table cellspacing="2" cellpadding="3" border="1" width="40%">
      <tr>
        <td width="20%">
          <h4>
            Course #
          </h4></td>
        <td width="20%">
          <h4>
            Prerequisite Course #
          </h4></td>
      </tr><%while (rs.next ())
    {
    out.println("<tr>");
    out.println("<td>" + 
      rs.getString("p_coursenum") + "</td><td> " +     
      rs.getString("p_prereqnum") + "</td>");
    out.println("</tr>");
    } %>
        </table>
    </body>
</html>
