<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
	response.setStatus(HttpServletResponse.SC_OK);
%>    
 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>404 에러 발생</title>
<style>
body
		{
			background-image: url(img/blizarrdbg.jpg);
			background-repeat: no-repeat;
			-webkit-background-size: cover;                 /* webkit부터 3줄은 웹페이지를 줄엿을때도 이미지를 설정한값으로 유지하게하려고 넣어줌. */
    		-moz-background-size: cover;
    		-o-background-size: cover; 
    		background-size: cover;
		}
</style>
</head>
<body>
	<b>
	<h1> 에러 코드 404 </h1>
	요청한 페이지는 존재하지 않습니다. URL을 다시 살펴보시기 바랍니다.
	</b>
</body>
</html>