<%@page import="servlet.SportsServlet"%>
<%@page language="java" import="java.util.*,dao.*,bean.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<title>USA</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="css/Head.css" />
	<link rel="stylesheet" type="text/css" href="css/delegationtable.css" />
	<link rel="stylesheet" type="text/css" href="css/medalRank.css" />
	<link rel="stylesheet" type="text/css" href="css/gallary.css" />
	<link rel="stylesheet" type="text/css" href="css/popdiv.css" />
	
	<jsp:useBean id="pictureBean" class="bean.Picture" scope="request"/>
	<jsp:useBean id="medalBean" class="bean.Medal" scope="request"/>
    <% DelegationDao delegationDao = new DelegationDao(); %>
    <% PictureDao picDao = new PictureDao(); %>
    <%String delegationName = request.getParameter("delegation");//USA%>
    <% List<String> result_list = delegationDao.getMedalList(delegationName); %> <!-- name rank event -->
    <% List<String> pic_list = delegationDao.getListPic(delegationName); %><!-- pics for above events -->
    <% List<String> sports_list = delegationDao.getSports(delegationName);%><!-- sports that delegation takes part in -->
    <% List<String> gallery_list = picDao.getDeleGallery(delegationName); %><!-- gallery pics of this country -->
    
<!-- event_name,team_name as name,rank,type,sports_nam -->

	<script src="js/jquery.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
        
      
        function popDetailWin(element) {
            document.getElementById(element).style.display = "block";       
        }

        function clsDetailWin(element) {
            document.getElementById(element).style.display = "none";
        }
	</script>

	<style type="text/css">
		#person td {
			margin: 20px;
		}
	</style>
</head>

<body style="z-index: 100;">
<!-- header -->
<div id="page-head"></div>

<!--countryName-->
<div class="head" style="background-color: midnightblue;">
	<h1><%=pictureBean.getDelegation_name() %></h1>
</div>
<br />
<br />
<!--medalRank-->
<div class="rank">
	<div class="flag" style="float: left;">
		<img src="<%=pictureBean.getPath()%>" />
	</div>
	<div class="medal" style="float: left;">
		<div class="medalwrapper">
			<div id="medalpic">
				<img src="img/ranking_1_medal.png" />
			</div>
			<div id="amount" style="color: gold;"><%=medalBean.getGold()%></div>
		</div>
		<div class="medalwrapper">
			<div id="medalpic">
				<img src="img/ranking_2_medal.png" />
			</div>
			<div id="amount" style="color: silver;"><%=medalBean.getSilver()%></div>
		</div>
		<div class="medalwrapper">
			<div id="medalpic">
				<img src="img/ranking_3_medal.png" />
			</div>
			<div id="amount" style="color: brown;"><%=medalBean.getBronze()%></div>
		</div>
	</div>
</div>
<br />
<br />
<div style="width: 80%; margin: 0 auto;">
	<!--medalWin-->
	<div class="win">
		<div class="heading">
			MEDALS
		</div>
		<div class="data">
			<table border="0" cellspacing="0" cellpadding="0" rules="rows">
				<tr class="tableHead">
					<th>DISCIPLINE</th>
					<th>NAME</th>
					<th>EVENT</th>
					<th>MEDAL</th>
				</tr>
				
				<% for(int i=0;i<result_list.size();i+=5){ %>
				<%="<tr class='tableData'>"+
					"<td>"+
						"<div id='pic'>"+
							"<a href=SportsServlet?Sports="+result_list.get(i+4)+">"+//Swimming
								"<img src='"+pic_list.get(i)+"' />"+//运动的小图标
							"</a>"+
						"</div>"+
					"</td>"+
						
					"<td>"+
						"<div>"+
							"<strong><a href="%>
							<% if(result_list.get(i+3).toUpperCase().equals("TEAM")) {%>
							<%="TeamDetailServlet?Event=" + java.net.URLEncoder.encode(result_list.get(i)).replace("+", "%20")+"&delegation="+delegationName + ">"%>
							<% }else { %>
							<%="IndividualDetailServlet?AthleteName=" +java.net.URLEncoder.encode(result_list.get(i+1)).replace("+", "%20") +">"%><%} %>
								<%=result_list.get(i+1)%>
								<%="</a>" %> 
							<%="</strong>"+
						"</div>"+
					"</td>"+
						
					"<td>"+
						"<div>"+
							"<a href="%>
							<% if(result_list.get(i+3).toUpperCase().equals("TEAM")) {%>
							<%="TeamServlet?Sports="+result_list.get(i+4)+"&Event="+java.net.URLEncoder.encode(result_list.get(i)).replace("+", "%20")+ ">" %>
							<% } else { %>
							<%="IndividualServlet?Sports="+result_list.get(i+4)+"&Event="+java.net.URLEncoder.encode(result_list.get(i)).replace("+", "%20") + ">"%><%} %>
							<%=result_list.get(i)+ "</a>"+//event name
						"</div>"+
					"</td>"+
					"<td>"+
						"<div id='pic'>"+
							"<img src='img/ranking_"+result_list.get(i+2)+"_medal.png'"
					+"/>"+
						"</div>"+
					"</td>"+
				"</tr>" %>
				<% } %>
				
			</table>
		</div>
	</div>
	<br />
	<br />
	<!--participant-->
	<div class="win">
		<div class="heading">
			PARTICIPANT
		</div>
		<div class="data">
			<table border="0" cellspacing="0" cellpadding="0" rules="rows">
				<tr class="tableHead">
					<th>EVENT</th>
					<th>Female</th>
					<th>Male</th>
					<th>TOTAL</th>
				</tr>
				<% for(int i =0;i<sports_list.size();i++){ %>
				<%="<tr class='tableData'>"+
					"<td>"+
						"<div class='link'>"+
							"<button id='teambtn' onclick=popDetailWin('myWindow',) style='border: 0;background-color: white;text-decoration: underline'>"+
						sports_list.get(i)+"</button>"+
						"</div>"+
					"</td>"+
					"<td>"+
						"<div>"+
					delegationDao.getMemAmount(delegationName,sports_list.get(i)).get(0) +
					"</div>"+
					"</td>"+
					"<td>"+
						"<div>"+
						delegationDao.getMemAmount(delegationName,sports_list.get(i)).get(1)+
						"</div>"+
					"</td>"+
					"<td>"+
						"<div>"+
						(int)(delegationDao.getMemAmount(delegationName,sports_list.get(i)).get(0)+
						delegationDao.getMemAmount(delegationName,sports_list.get(i)).get(1))+
						"</div>"+
					"</td>"+
				"</tr>" %>
				<% } %>
			</table>
		</div>
	</div>
	<div style="width: 80%; margin: 0 auto;">
		<div>
			<h2>GALLARY</h2>
			<hr />
		</div>
		<div id="gallary">
		<% for(int i=0;i<gallery_list.size();i++){ %>
		<%="<img src="+gallery_list.get(i)+" />"%>
		<%} %>
		</div>
	</div>
</div>

<br />
<br />
</div>
<!-- footer -->
<div id="page-footer"></div>

<!--background-->
<div id="myWindow" class="detailParticipant">
	<!-- content -->
	<div class="content">
		<!--close part-->
		<span class="close" onclick="clsDetailWin('myWindow')">&times;</span>
		<div class="tobechanged" style="text-align: center;margin: 20px;">
			Athletes
		</div>
		<div id="person" style="align-content: center; margin: 10px;text-align: center;">
			<table border="0" cellspacing="0" cellpadding="0" rules="rows" style="width: 700px;">
				<tr>
					<th>PORTRAIT</th>
					<th style="text-align:center;">NAME</th>
					<%!List<Picture> participants_list; %>
					<% for(int j=0;j<sports_list.size();j++){ %>
					<% participants_list = picDao.getMember(delegationName,sports_list.get(j)); %><!-- participants pic of usa swimming team -->
					<% } %>
					<% for(int i=0;i<participants_list.size();i++) {%>
					<%="<tr>"+
						"<td>"+
							"<div><img src="+participants_list.get(i).getPath()+" style='border-radius: 50%; width: 50px;height: 50px;' /></div>"+
						"</td>"+
						"<td>"+participants_list.get(i).getAthlete_name()+"</td>"+
					"</tr>" %>
					<% } %>
					
				</tr>
			</table>
		</div>

	</div>

</div>
</body>

</html>