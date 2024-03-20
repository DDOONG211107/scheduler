<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 
<%@ page import="java.sql.DriverManager" %> <!--커넥터파일을 찾는 라이브러리-->
<%@ page import = "java.sql.Connection" %> <!-- db에 연결하는 라이브러리-->
<%@ page import="java.sql.PreparedStatement" %> <!--sql을 전송하는 라이브러리 -->
<%@ page import="java.sql.ResultSet" %> <!-- table데이터를 저장하는 라이브러리. select할때 필요하다 -->
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.io.*" %>

<% 
    request.setCharacterEncoding("utf-8"); 

    String userIdx =  ((String) session.getAttribute("userIdx"));
    boolean isSame = true;
    boolean isError = true;

    String email = request.getParameter("email");
    String id = request.getParameter("id");
    String checkId = request.getParameter("checkId");
    String checkEmail = request.getParameter("checkEmail");
    String alertString = "";

    // 마이페이지 수정일 경우 이 값들을 사용한다
    String isEdit = request.getParameter("isEdit");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String date = request.getParameter("date");

    try {
        
        // String emailReg = "^([a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*.[a-zA-Z0-9]*){1,20}$";
        String emailReg = "^(?:[a-zA-Z0-9]*[-_.]*[a-zA-Z0-9]*@[a-zA-Z0-9]*\\.[a-zA-Z0-9]*){1,20}$";
        Pattern pattern = Pattern.compile(emailReg);
        if(!pattern.matcher(email).matches()){
            throw new IllegalArgumentException("서버: 이메일 오류");
        }

        isError = false;

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect  = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","scheduler_admin","password");


        String sql = "SELECT * FROM account WHERE email = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1,email);

        ResultSet result = query.executeQuery();

        // 이메일이 중복이 아니면 무조건 false -> 사용 가능
        if(!result.next()){
            isSame = false;
        } else {
             // 이메일이 중복이긴 하지만 그 이메일이 내꺼일때
            if(result.getString(1).equals(userIdx)){
                isSame = false;
            }
            else{
                isSame = true;
            }
        }
    } catch(IllegalArgumentException e){
        alertString = "서버: 이메일은 정확한 형식으로 1자 이상 20자 이하로 입력해주세요";
    }

%>

 <script>
   const isSame = <%=isSame%>;
   const isError = <%=isError%>;
   const checkId = "<%=checkId%>";
   const checkEmail = "<%=checkEmail%>";
   const id = "<%=id%>";
   const email = "<%=email%>";

   const isEdit = <%=isEdit%>;
   const year = "<%=year%>";
   const month = "<%=month%>";
   const date = "<%=date%>";

   if(isError){
     const alertString = "<%=alertString%>";
     alert(alertString);

     if(isEdit){
         window.history.back();
     }else{
         window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId="+checkId+"&checkEmail=false";
     }

   }else{
     if(isEdit){
         if(isSame){
         alert(`해당 이메일은 사용할 수 없습니다.`);
        //  window.history.back();
        //  window.location.href = "editMypage.jsp?email="+email+"&checkEmail=false";
         window.history.back();
        
         } else {    
         alert('해당 이메일은 사용할 수 있습니다.');
         // window.history.back();
         window.location.href = "editMypage.jsp?newEmail="+email+"&checkEmail=true&year="+year+"&month="+month+"&date="+date;
         }
     }
     else {
         if(isSame){
         alert(`해당 이메일은 사용할 수 없습니다.`);
        //  window.history.back();
         window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId="+checkId+"&checkEmail=false";
        
         } else {    
         alert('해당 이메일은 사용할 수 있습니다.');
         // window.history.back();
         window.location.href = "signup.jsp?id="+id+"&email="+email+"&checkId="+checkId+"&checkEmail=true";
         }
     }
   }

  
  
  
  
 </script>