<%-- 
    Document   : index
    Created on : Dec 6, 2014, 3:04:39 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UC Merced Database</title>
    </head>
    <body>
        <h1>UC Merced Instructors</h1>
        <form action="index.html">
            <input type="submit" value="Back" name="back" />
        </form><form action="fullIns.jsp">
            <input type="submit" value="Full List" name="flist" />
        </form>
        <jsp:useBean id="insbean" class="DataManage.DBQuery" scope="session"/><%
            ResultSet rs;
            ResultSet schls;
            String filter = request.getParameter("Schools");
            
            if (filter == null || filter.equals("None")) {
                rs = insbean.getAllInstructors();
            } else {
                rs = insbean.getInstructorSchool(filter);
            }
            schls = insbean.getSchools();
        %>
        
        <form action="InsDir.jsp">       
            Filter by School     <select name="Schools">           
            <option>None</option>
            <%
            while (schls.next()) {
               out.println("<option>" +
                        schls.getString("s_schoolname") + "</option>");
            }
            %>
            </select>
            <input type="submit" value="Submit" name="filter" />
        </form>
        
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

    </body>
</html>
