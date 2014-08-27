<html>
<body>
<% response.write(request.querystring("fname"))
	 response.write(" " & request.querystring("lname")) %>
</body>
</html>