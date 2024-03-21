<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->
<%@ page import="java.io.*" %>
<% 
    request.setCharacterEncoding("utf-8"); 

    boolean delete = false;
    boolean isError = true;
    String userIdx =  ((String) session.getAttribute("userIdx")) ;

    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String date = request.getParameter("date");
    String idx = request.getParameter("idx");
    String alertString = "";


    try{
        if(userIdx.equals("")){
            throw new Exception("로그인 후 이용해주세요");
        }

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");

        String sql = "Delete FROM schedule WHERE idx = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,idx);

        query.executeUpdate();
        
        delete = true;
        isError = false;
    }catch(Exception e){
        alertString = e.getMessage();
    }
    
%>

<script>
    const userIdx = <%=userIdx%>;
    if(!userIdx){
        alert("로그인 후 이용해주세요.");
        window.location.href = "../index.html";
    }

    const year = <%=year%>;
    const month = <%=month%>;
    const date = <%=date%>;
    const idx = <%=idx%>;
    const alertString = "<%=alertString%>";
    const isError = <%=isError%>;

    if(isError){
        alert(alertString);
    }

    // window.close();
    window.location.href = "../page/scheduleDetail.jsp?year="+year+"&month="+month+"&date="+date;

</script>