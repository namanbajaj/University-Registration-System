<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<body>
	<form method="POST" action="AddItem.jsp">
		Add Professor
		<br>
		ID <input type="text" name="id">
		<br>
		Name <input type="text" name="name">
		<br>
		Phone Number <input type="text" name="number">
		<br>
		Office <input type="text" name="office">
		<br>
		Password <input type="text" name="password">
		<br>
		<input type="submit" value="Add Professor" name="addprofessor"/>		
	</form>
	<br>
	<form method="POST" action="AddItem.jsp">
		Add Student
		<br>
		ID <input type="text" name="id">
		<br>
		Name <input type="text" name="name">
		<br>
		Phone Number <input type="text" name="number">
		<br>
		Dob (mm/dd/yyyy) <input type="text" name="dob">
		<br>
		Password <input type="text" name="password">
		<br>
		<input type="submit" value="Add Student" name="addstudent"/>		
	</form>
	<br>
	<form method="POST" action="AddItem.jsp">
		Add Course
		<br>
		ID <input type="text" name="id">
		<br>
		Section <input type="text" name="section">
		<br>
		Semester<input type="text" name="semester">
		<br>
		Course Name <input type="text" name="coursename">
		<br>
		Department Name <input type="text" name="deptname">
		<br>
		Credits <input type="text" name="credits">
		<br>
		Day and Time <input type="text" name="times">
		<br>
		Professor ID <input type="text" name="pid">
		<br>
		Prerequisites (enter course IDs separated by a comma and no spaces) <input type="text" name="prereqs">
		<br>
		<input type="submit" value="Offer Course" name="addcourse"/>		
	</form>
</body>
</html>