<%-- 
    Document   : advDir
    Created on : Dec 6, 2014, 6:40:41 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Advisor Directory</title>
    </head>
    <body>
        <h1>Advisor Directory</h1>
        <form action="index.html">
            <input type="submit" value="Back" name="back" />
        </form>
        <jsp:useBean id="advbean" class="DataManage.DBQuery" scope="session"/><%
            ResultSet rs;
            String filter = request.getParameter("Schools");
            if (filter == null || filter.equals("None")) {
                rs = advbean.getAdvisors();
            } else {
                rs = advbean.getAdvisorSchool(filter);
            }
            ResultSet schls;
            schls = advbean.getSchools();
        %>
        
        <form action="advDir.jsp">       
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
      rs.getString("a_advisorname") + "</td><td> " + 
      rs.getString("a_advises") + "</td><td> " +  
      rs.getString("a_advisoremail") + "</td>");
    out.println("</tr>");
    } %>
    </body>
</html>
