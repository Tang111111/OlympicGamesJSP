<%@page language="java" import="java.util.*,dao.*,bean.*"  %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>DELEGATION</title>

	<link rel="stylesheet" type="text/css" href="css/Head.css"/>
	<link rel="stylesheet" type="text/css" href="css/listStyle.css"/>
	<script src="js/jquery.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
	</script>
		
</head>
<%! PictureDao picDao=new PictureDao(); %>
<%  List<Picture> deleLogo=picDao.getAllDelegation(); 
	for(int i=0;i<deleLogo.size();i++){
		System.out.println(deleLogo.get(i).getPath());
	}
%>
<body>

<!-- header -->
<div id="page-head"></div>

<div class="head" style="background-color: blueviolet;">
	<h1>DELEGATION</h1>
</div>
<br />
<br />
<div style="width: 80%; margin: 0 auto;">
	<div style="width: auto;margin: 0 auto;"align="middle">
		<div class='select' align="middle">
		<% for(int i=0;i<deleLogo.size();i++){%>
		<%="<li>"+
				"<a href=DelegationServlet?delegation="+deleLogo.get(i).getDelegation_name()+">"+
				"<div id='spots_icon'>"+
					"<img src="+deleLogo.get(i).getPath()+" width='100' height='80'>"+
				"</div >"+
				"<div id="+deleLogo.get(i).getDelegation_name()+">"+
					deleLogo.get(i).getDelegation_name()+
				"</div>"+			
			"</a>"+
		"</li>" %>
		<% } %>
		
			
		</div>
	</div>

</div>
</div>
<!-- footer -->
<div id="page-footer"></div>
</body>

</html>