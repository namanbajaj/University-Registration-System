<%@page import="java.util.Enumeration"%>
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
Enumeration<String> parameterNames = request.getParameterNames();
String sid = "";
String cid = "";
String section = "";
String semester = "";

while (parameterNames.hasMoreElements()) {
    String paramName = parameterNames.nextElement();
    String[] pair = paramName.split(":");
    //out.print(pair[1]);
	//out.print("<br>");
	if(pair[0].equals("sid"))
		sid = pair[1];
	if(pair[0].equals("cid"))
		cid = pair[1];
	if(pair[0].equals("section"))
		section = pair[1];
	if(pair[0].equals("semester"))
		semester = pair[1];
}

// System.out.println(sid);
// System.out.println(cid);
// System.out.println(section);
// System.out.println(semester);

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();

	String str = "INSERT INTO Registered value (" + sid + ", " + cid + ", " + section + ", " + semester + ", \"A\");" ;
	int x = stmt.executeUpdate(str);      
	
	out.println("Registration Successful");
}
catch(Exception e){
	e.printStackTrace();
	out.println("Registration Failed");
}
 			

%>
</body>
</html>