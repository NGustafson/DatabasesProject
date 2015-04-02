<%-- 
    Document   : majorList
    Created on : Dec 6, 2014, 8:49:44 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Major List</title>
    </head>
    <body>
        <h1>List of Majors at UC Merced</h1>
        <form action="index.html">
            <input type="submit" value="Back" name="back" />
        </form>
        <jsp:useBean id="majbean" class="DataManage.DBQuery" scope="session"/><%
            ResultSet rs;
            String filter = request.getParameter("Schools");
            if (filter == null || filter.equals("None")) {
                rs = majbean.getMajors();
            } else {
                rs = majbean.getMajorSchool(filter);
            }
            ResultSet schls;
            schls = majbean.getSchools();
        %>
        
        <form action="majorList.jsp">       
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
        
         <table cellspacing="2" cellpadding="3" border="1" width="30%">
      <tr>
        <td width="75%">
          <h4>
            Major
          </h4></td>
        <td width="25%">
          <h4>
            Type
          </h4></td>
      </tr><%while (rs.next ())
    {
    out.println("<tr>");
    out.println("<td>" + 
      rs.getString("m_majortitle") + "</td><td> " +   
      rs.getString("m_majortype") + "</td>");
    out.println("</tr>");
    } %>
    </body>
</html>
