<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->
<%@ page import="java.io.*" %>

<%
    request.setCharacterEncoding("utf-8"); 

    try{
        String userIdx =  (String) session.getAttribute("userIdx");

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        String sql = "Delete FROM account WHERE idx = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,userIdx);

        query.executeUpdate();

        session.removeAttribute("userIdx");
        response.sendRedirect("../index.html");
    }catch(Exception e){
        alertString = e.getMessage();
    }

%>

