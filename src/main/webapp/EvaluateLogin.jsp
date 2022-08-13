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
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	// out.println(username + " " + password);

	out.print("Invalid Login");
	
	// check if admin
	if (username.equals("admin") && password.equals("admin")) {
		// out.println("ADMIN");
		response.sendRedirect("DepAdmin.jsp");
		return;
	}
	
	// check if professor	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
		String str = "SELECT * FROM Professor";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Professor.jsp");
		while(result.next()){
			if(result.getString("pid").equals(username) && result.getString("password").equals(password)){
				// out.print(result.getString("pname"));
				// response.sendRedirect("Professor.jsp");
				request.setAttribute("name", result.getString("pname"));
				request.setAttribute("pid", username);
				con.close();
				dispatcher.forward(request, response);
				return;
			}
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	// check if student
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT * FROM Student";
		ResultSet result = stmt.executeQuery(str);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Student.jsp");
		while(result.next()){
			if(result.getString("sid").equals(username) && result.getString("password").equals(password)){
				// out.print(result.getString("pname"));
				// response.sendRedirect("Professor.jsp");
				request.setAttribute("name", result.getString("sname"));
				request.setAttribute("sid", username);
				con.close();
				dispatcher.forward(request, response);
				return;
			}
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	%>
	
</body>
</html>