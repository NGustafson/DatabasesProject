<%-- 
    Document   : courseList
    Created on : Dec 6, 2014, 5:48:08 PM
    Author     : Nick
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Course Directory</title>
    </head>
    <body>
        <h1>Course Directory</h1>
        <form action="index.html">
            <input type="submit" value="Back" name="back" />
        </form>
        <form action="prereq.jsp">
            <input type="submit" value="Prerequisites" name="prereq" />
        </form>
        <jsp:useBean id="crsbean" class="DataManage.DBQuery" scope="session"/><%
            ResultSet rs;
            String filter = request.getParameter("crsNum");
            if (filter == null || filter.equals("None")) {
                rs = crsbean.getCourseList();
            } else {
                rs = crsbean.getCourseFiltered(filter);
            }            
        %>

        <form action="courseList.jsp">       
            Filter by Course #
            <input type="text" name="crsNum" value="None" size="20" />
            
            <input type="submit" value="Submit" name="filter" />
        </form>

        <table cellspacing="2" cellpadding="3" border="1" width="100%">
      <tr>
        <td width="7%">
          <h4>
            CRN
          </h4></td>
        <td width="10%">
          <h4>
            Course #
          </h4></td>
        <td width="25%">
          <h4>
            Course Title
          </h4></td>
        <td width="5%">
          <h4>
            Type
          </h4></td>
        <td width="5%">
          <h4>
            Days
          </h4></td>
        <td width="3%">
          <h4>
            Units
          </h4></td>
        <td width="7%">
          <h4>
            Bldg/RM
          </h4></td>
        <td width="10%">
          <h4>
            Start-End
          </h4></td>
        <td width="10%">
          <h4>
            Time
          </h4></td>
        <td width="13%">
          <h4>
            Instructor
          </h4></td>
          <td width="5%">
          <h4>
              <a href="newCourse.jsp?crn = ">Insert Course</a>
          </h4></td>
      </tr><%while (rs.next ())
    {
    out.println("<tr>");
    out.println("<td>" + 
      rs.getString("c_crn") + "</td><td> " + 
      rs.getString("c_coursenumber") + "</td><td> " +
      rs.getString("c_coursetitle") + "</td><td> " +
      rs.getString("c_coursetype") + "</td><td> " +
      rs.getString("c_coursedays") + "</td><td> " +
      rs.getString("c_units") + "</td><td> " +
      rs.getString("ccr_bldgrm") + "</td><td> " +
      rs.getString("c_coursestartend") + "</td><td> " +
      rs.getString("c_coursetime") + "</td><td> " +
      rs.getString("ci_instructorname") + 
      "</td><td> <a href=\"editCourse.jsp?crn=" + rs.getString("c_crn") + 
      "\">Edit</a> <a href=\"deleteCourse.jsp?crn=" + rs.getString("c_crn") + 
      "\">Delete</a></td>");
    out.println("</tr>");
    } %>
    </table>
    </body>
</html>
