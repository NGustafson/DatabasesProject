<%-- 
    Document   : fullIns
    Created on : Dec 7, 2014, 11:27:34 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instructor List</title>
    </head>
    <body>
        <h1>Full List of Instructors</h1>
        <form action="InsDir.jsp">
            <input type="submit" value="Back" name="back" />
        </form>
        <jsp:useBean id="insbean" class="DataManage.DBQuery" scope="session"/><%
            ResultSet rs;
            rs = insbean.getInstructors();
        %>
        <table cellspacing="2" cellpadding="3" border="1" width="100%">
      <tr>
          
        <td width="33%">
          <h4>
            Name
          </h4></td>
        <td width="33%">
          <h4>
            Title
          </h4></td>
        <td width="34%">
          <h4>
            Email
          </h4></td>
      </tr><%while (rs.next ())
    {
    out.println("<tr>");
    out.println("<td>" + 
      rs.getString("i_instructorname") + "</td><td> " + 
      rs.getString("i_instructortitle") + "</td><td> " +  
      rs.getString("i_instructoremail") + "</td>");
    out.println("</tr>");
    } %>
        </table>
    </body>
</html>
