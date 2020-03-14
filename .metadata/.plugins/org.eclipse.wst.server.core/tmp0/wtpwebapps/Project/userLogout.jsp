<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	session.invalidate();        //클라이언트의 모든 세션을 해제
%>
<script>
	location.href = 'index.jsp';
</script>