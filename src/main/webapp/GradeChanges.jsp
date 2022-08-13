<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
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
    while (parameterNames.hasMoreElements()) {
        String paramName = parameterNames.nextElement();
    	if(!paramName.equals("pid")){
            String[] pair = paramName.split("\\|");
            String sid = pair[0];
            String cid = pair[1];
        	String newGrade = request.getParameterValues(paramName)[0];
        	if(newGrade.equals(""))
            	out.print("Student " + sid + " in course " + cid + " grade has remained the same");
        	
        	else{
        		try {
        			ApplicationDB db = new ApplicationDB();	
        			Connection con = db.getConnection();
        			Statement stmt = con.createStatement();
                	
        			String str = "UPDATE Registered SET grade= \"" + newGrade + "\" WHERE sid = " + sid + " AND cid = " + cid + ";";
        			int x = stmt.executeUpdate(str);        			
        			
                	out.print("Student " + sid + " in course " + cid + " grade has been changed to ");
    				out.println(newGrade + "<br>");
    				
    				con.close();
                }
                catch(Exception e){
                	e.printStackTrace();
                	out.print("Student " + sid + " in course " + cid + " grade was unable to be changed to ");
    				out.println(newGrade + "<br>");
                }
        	}
    	}
    }
    out.print("Go back and refresh page to see results");
    %>
</body>
</html>