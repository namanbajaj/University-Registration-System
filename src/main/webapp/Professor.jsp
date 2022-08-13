<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.finalproject.pkg.*"%>
    <!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
out.println("Welcome, Professor " + request.getAttribute("name"));
%>
<form method="POST" action="GradeChanges.jsp">
<br>
	<%
		List<String> list = new ArrayList<String>();

		try {

			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			Statement stmt = con.createStatement();
			
			String pid = "" + request.getAttribute("pid");
			String str = "SELECT DISTINCT s.sid, c.cid, r.grade, r.semester FROM Student s, Registered r, Course c, Teaches t WHERE s.sid=r.sid AND r.cid=t.cid AND r.section=t.section AND r.cid=c.cid AND t.pid=" + pid +";";
			ResultSet result = stmt.executeQuery(str);
						
			out.print("<table>");

			out.print("<tr>");
			
			out.print("<td>");
			out.print("Semester | ");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Student ID | ");
			out.print("</td>");

			out.print("<td>");
			out.print("Course ID | ");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Current Grade | ");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Change Grade To");
			out.print("</td>");
			
			out.print("</tr>");

			while (result.next()) {
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getString("r.semester"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("s.sid"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("c.cid"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("r.grade"));
				out.print("</td>");
				
				out.print("<td>");
				out.print("<input type=\"text\" name=\"" + result.getString("s.sid") + "|" + result.getString("c.cid") + "\">");
				out.print("</td>");
				
				out.print("<td>");
			}
			out.print("</table>");
			
			// out.print("<input type=\"submit\" value=\"Submit Grade Changes\">");

			con.close();

		} catch (Exception e) {
		}
		// out.print("input type=\"submit\" name=\"pid\" value=\"" + request.getAttribute("pid" + "\")");
	%>
	
	<input type="submit" value="Submit Grade Changes">
		<% out.print("<input type=\"hidden\" name=\"pid\" value=\"" + request.getAttribute("pid") + "\">"); %>
	
</form>

</body>
</html>