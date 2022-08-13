<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="com.finalproject.pkg.*"%>
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
out.println("Welcome, " + request.getAttribute("name"));

// List of courses currently enrolled in
try {

	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	
	String sid = "" + request.getAttribute("sid");
	String str = "SELECT DISTINCT r.semester, r.cid, r.section, r.grade FROM Student s, Course c, Registered r WHERE s.sid= " + sid + " AND s.sid=r.sid";
	ResultSet result = stmt.executeQuery(str);
				
	out.print("<table>");

	out.print("<tr>");
	
	out.print("<td>");
	out.print("Semester | ");
	out.print("</td>");

	out.print("<td>");
	out.print("Course ID | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Section | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Current Grade");
	out.print("</td>");
	
	out.print("</tr>");

	while (result.next()) {
		out.print("<tr>");

		out.print("<td>");
		out.print(result.getString("r.semester"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("r.cid"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("r.section"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("r.grade"));
		out.print("</td>");
		
		out.print("<td>");
	}
	out.print("</table>");
	
	// out.print("<input type=\"submit\" value=\"Submit Grade Changes\">");

	con.close();

} catch (Exception e) {
	e.printStackTrace();
}

// Register for courses
try {

	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	
	String sid = "" + request.getAttribute("sid");
	String str = "SELECT cid, section, semester, cname, dname, credits, datestimes FROM Course WHERE (cid, section, semester) NOT IN (SELECT DISTINCT cid, section, semester FROM Registered WHERE sid=" + sid + ");";
	// out.print(str);
	ResultSet result = stmt.executeQuery(str);
				
	ArrayList<Integer> unRegistered = new ArrayList<Integer>();
	
	
	out.print("<table>");

	out.print("<tr>");
	
	out.print("<td>");
	out.print("Course | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Section | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Semester | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Name | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Department | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Credits | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Dates/Times | ");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Prerequisites |");
	out.print("</td>");
	
	out.print("<td>");
	out.print("Register ");
	out.print("</td>");
	
	out.print("</tr>");

	while (result.next()) {
		System.out.println(result.getString("cid") + " " + result.getString("section") + " " + result.getString("semester"));
		
		out.print("<tr>");

		out.print("<td>");
		out.print(result.getString("cid"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("section"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("semester"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("cname"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("dname"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("credits"));
		out.print("</td>");
		
		out.print("<td>");
		out.print(result.getString("datestimes"));
		out.print("</td>");
		
		out.print("<td>");
		String prereqQuery = "SELECT prereq FROM Prerequisite WHERE cid=" + result.getString("cid") + ";";
		// out.print(prereqQuery);
		ApplicationDB db2 = new ApplicationDB();	
		Connection con2 = db2.getConnection();	
		Statement stmt2 = con2.createStatement();
		ResultSet preR = stmt2.executeQuery(prereqQuery);
		while (preR.next()){
			out.print(preR.getString("prereq") + ", ");
		}
		con2.close();
		out.print("</td>");
		
		
		// Can register, check if alrady enrolled in course but different section or prerequisites not fulfilled
		boolean canRegister = true;
		// Prerequisities not met
		// get list of previous courses taken before current course semester
		ArrayList<Integer> prevCourses = new ArrayList<Integer>();
		ApplicationDB db5 = new ApplicationDB();	
		Connection con5 = db5.getConnection();	
		Statement stmt5 = con5.createStatement();
		String getCourses = "SELECT cid FROM Registered WHERE sid=" + sid + " AND " + result.getString("semester") + "> semester" + ";";
		ResultSet validCourses = stmt5.executeQuery(getCourses);
		while(validCourses.next())
			prevCourses.add(Integer.parseInt(validCourses.getString("cid")));
		con5.close();

		ApplicationDB db4 = new ApplicationDB();	
		Connection con4 = db4.getConnection();	
		Statement stmt4 = con4.createStatement();
		String getPrereq = "SELECT prereq FROM Prerequisite WHERE cid=" + result.getString("cid") + ";";
		ResultSet takenPrereqs = stmt4.executeQuery(getPrereq);
		while(takenPrereqs.next())
			if(!prevCourses.contains(Integer.parseInt("" + takenPrereqs.getString("prereq"))))
				canRegister = false;
		
		if(!canRegister){
			out.print("<td>");
			out.print("Prerequisites not met");
			out.print("</td>");
		}
		
		if(canRegister){
			// Already enrolled, same semester, same course, different section
			ApplicationDB db3 = new ApplicationDB();	
			Connection con3 = db3.getConnection();	
			Statement stmt3 = con3.createStatement();
			String inCourse = "SELECT cid, section, semester FROM Registered WHERE sid=" + sid + ";";
			ResultSet dupCourse = stmt3.executeQuery(inCourse);
			while(dupCourse.next()){
				String curcid = "" + dupCourse.getString("cid");
				String cursemester = "" + dupCourse.getString("semester");
				if(curcid.equals(result.getString("cid")) && cursemester.equals(result.getString("semester"))){
					canRegister = false;
					break;
				}
			}
			con3.close();
			
			if(!canRegister){
				out.print("<td>");
				out.print("Registered in different section");
				out.print("</td>");
			}
		}

		
		// Check if Register button should be displayed
		if(canRegister){
			out.print("<td>"); %>
			<form method="POST" action=Register.jsp>
			<input type=submit value=Register>
			<% out.print("<input type=\"hidden\" name=\"sid:" + sid + "\">"); %>
			<% out.print("<input type=\"hidden\" name=\"cid:" + result.getString("cid") + "\">"); %>
			<% out.print("<input type=\"hidden\" name=\"section:" + result.getString("section") + "\">"); %>
			<% out.print("<input type=\"hidden\" name=\"semester:" + result.getString("semester") + "\">"); %>
			
			
			</form>
			<% out.print("</td>");
		}
		
		out.print("<td>");
	}
	out.print("</table>");
	
	// out.print("<input type=\"submit\" value=\"Submit Grade Changes\">");

	con.close();

} catch (Exception e) {
	e.printStackTrace();
}

%>

</body>
</html>