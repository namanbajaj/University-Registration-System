<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.finalproject.pkg.*"%>
    <!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Added Status</title>
</head>
<body>
<%
boolean isProfessor = request.getParameter("addprofessor") != null;
boolean isStudent = request.getParameter("addstudent") != null;
boolean isCourse = request.getParameter("addcourse") != null;

if(isProfessor){
// 	out.println("Adding Professor With Values");
// 	out.println("<br>");
	int id = Integer.parseInt(request.getParameter("id"));
	String name = request.getParameter("name");
	String number = request.getParameter("number");
	int office = Integer.parseInt(request.getParameter("office"));
	String password = request.getParameter("password");
// 	out.println("Professor ID: " + id);
// 	out.println("<br>");
// 	out.println("Name: " + name);
// 	out.println("<br>");
// 	out.println("Phone Number: " + number);
// 	out.println("<br>");
// 	out.println("Office Number: " + office);
// 	out.println("<br>");
// 	out.println("Password: " + password);
// 	out.println("<br>");
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String str = "INSERT INTO Professor value (" 
		+ id 
		+ ", \"" + name
		+ "\", " + number
		+ ", " + office
		+ ", \"" + password
		+ "\");";
// 		out.println(str);

		int x = stmt.executeUpdate(str);
// 		out.println("<br>");
		out.println("Addition successful");
		
		con.close();
	}
	catch(Exception e){
		e.printStackTrace();
		out.println("Addition unsuccessful");
	}
}

else if(isStudent){
// 	out.println("Adding Student With Values");
// 	out.println("<br>");
	int id = Integer.parseInt(request.getParameter("id"));
	String name = request.getParameter("name");
	String number = request.getParameter("number");
	String dob = request.getParameter("dob");
	String password = request.getParameter("password");
// 	out.println("Student ID: " + id);
// 	out.println("<br>");
// 	out.println("Name: " + name);
// 	out.println("<br>");
// 	out.println("Phone Number: " + number);
// 	out.println("<br>");
// 	out.println("DOB: " + dob);
// 	out.println("<br>");
// 	out.println("Password: " + password);
// 	out.println("<br>");
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();

		String str = "INSERT INTO Student value (" 
		+ id 
		+ ", \"" + name
		+ "\", " + number
		+ ", \"" + dob
		+ "\", \"" + password
		+ "\");";
// 		out.println(str);

		int x = stmt.executeUpdate(str);
// 		out.println("<br>");
		out.println("Addition successful");
		
		con.close();
	}
	catch(Exception e){
		e.printStackTrace();
		out.println("Addition unsuccessful");
	}
}

else if(isCourse){
// 	out.println("Adding Course With Values");
// 	out.println("<br>");
	int id = Integer.parseInt(request.getParameter("id"));
	int section = Integer.parseInt(request.getParameter("section"));
	int semester = Integer.parseInt(request.getParameter("semester"));
	String coursename = request.getParameter("coursename");
	String deptname = request.getParameter("deptname");
	int credits = Integer.parseInt(request.getParameter("credits"));
	String times = request.getParameter("times");
	int pid = Integer.parseInt(request.getParameter("pid"));
	ArrayList<String> prereqs = new ArrayList<String>();
	Collections.addAll(prereqs, request.getParameter("prereqs").split(","));
// 	out.println("Course ID: " + id);
// 	out.println("<br>");
// 	out.println("Course Section: " + section);
// 	out.println("<br>");
// 	out.println("Semester: " + semester);
// 	out.println("<br>");
// 	out.println("Course Name: " + coursename);
// 	out.println("<br>");
// 	out.println("Department Name: " + deptname);
// 	out.println("<br>");
// 	out.println("Credits: " + credits);
// 	out.println("<br>");
// 	out.println("Dates/Times: " + times);
// 	out.println("<br>");
// 	out.println("Professor ID: " + pid);
// 	out.println("<br>");
// 	out.println("Prerequisites: |");
	
// 	System.out.println(prereqs.size());
	boolean hasPrereqs = true;
	if(prereqs.get(0).equals(""))
		hasPrereqs = false;
// 	for(String prereq : prereqs)
// 		out.println(prereq + " | ");
// 	out.println("<br>");
	
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		// insert course
		String str = "INSERT INTO Course value (" 
		+ id 
		+ ", " + section
		+ ", " + semester
		+ ", \"" + coursename
		+ "\", \"" + deptname
		+ "\", " + credits
		+ ", \"" + times
		+ "\");";
// 		out.println(str);
		
		stmt.addBatch(str);
		// int x = stmt.executeUpdate(str);
// 		out.println("<br>");
		// out.println("Addition successful");
		
		// insert prerequisites
		str = "INSERT IGNORE INTO Prerequisite value (" + id;
		if(hasPrereqs){
			for(String p : prereqs){
// 				out.println(str + ", " + p + ");");
// 				out.println("<br>");
				stmt.addBatch(str + ", " + p + ");");
				// x = stmt.executeUpdate(str + ", " + p + ");");
			}
		}

		
		// insert teaches
		str = "INSERT INTO Teaches value (" + pid + ", " + id + ", " + section + ", " + semester + ");";
// 		out.println(str);
// 		out.println("<br>");
		stmt.addBatch(str);
		// x = stmt.executeUpdate(str);
		
		stmt.executeBatch();
		out.println("Addition successful");
		
		con.close();
		
	}
	catch(Exception e){
		e.printStackTrace();
		out.println("Addition unsuccessful");
	}

}


%>
</body>
</html>