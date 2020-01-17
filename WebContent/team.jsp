<%@page language="java" import="java.util.*,dao.*,bean.*"  %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Team sports details</title>
        <link rel="stylesheet" type="text/css" href="css/team.css" />
        <link rel="stylesheet" type="text/css" href="css/team_result.css" />
        <link rel="stylesheet" type="text/css" href="css/participant.css" />
    	<script type="text/javascript" src="js/sportsname.js"></script>
        <script src="js/jquery.js"></script>
	    <script type="text/javascript">
            $(document).ready(function () {
              $('#page-head').load('header(1).jsp');
              $('#page-footer').load('footer(1).jsp');
            });	
        </script>    
        <script type="text/javascript" src="js/jquery.tablesorter.js"></script>
        <link rel="stylesheet" type="text/css" href="css/theme.blue.css"/>
        
        
        <% String sportsName = request.getParameter("Sports");//Swimming
		   String eventName = request.getParameter("Event");//4X100M FREESTYLE RELAY MEN
		   PictureDao picDao = new PictureDao();
           ResultDao reDao = new ResultDao();
           
           List<String> otherSports=reDao.getList(sportsName);//导航栏用
           List<String> otherEvents=reDao.getTeamList(sportsName,eventName);//导航栏用
           List<Picture> team_pics = picDao.getT_Participant(eventName);//参赛国家的国旗地址和名字（上面展示用）
           List<Event> schedule = reDao.getSchedule(eventName); //三个赛程和日期,final,semifinal,preliminary,
           List<String> team_results;
           %>
    </head>
    
    <body>
    <!-- header -->
    <div id="page-head"></div>
 
    <div class="Team" style="font-family: 'microsoft sans serif';">
        <div class="sportsname">
        <nav class="sportsnamenav">
          <div class="container2">
                    <div class="drop-down">
                    	<button class="dropbutton" onclick="myFunction1()"><%=sportsName %></button>
                    	<div class="content" id="myDropdown1">
                      <%for (int i=0;i<otherSports.size();i++){%>
                    	<%="<a href=SportsServlet?Sports="+(java.net.URLEncoder.encode(otherSports.get(i), "UTF-8")).replace("+", "%20")+" >" + otherSports.get(i) + "</a>"%>
                    	<%} %>
                    	</div>
                   	</div> 
                   	
                   	<div class="drop-down">
                       	<button class="dropbutton">Team</button>
                   	</div>                  
                      
                  	<div class="drop-down">
                     	<button class="dropbutton" onclick="myFunction2()"><%=eventName %></button>
                     	<div class="content" id="myDropdown2">
                       <%for(int i=0;i<otherEvents.size();i++){ %>
                     	<%="<a href=TeamServlet?Sports="+sportsName+"&Event="+(java.net.URLEncoder.encode(otherEvents.get(i), "UTF-8")).replace("+", "%20")+" >" + otherEvents.get(i) + "</a>" %>
                     	<%} %>
                     	</div>
                   	</div> 
           
          </div>
        </nav>
        <div class="holder">
               <h1><%=eventName %></h1>
   		</div>
   		</div>


    	<div class="participant">
    		<section class="related-athletes alt first">
    			<header class="heading">
    				<h2>Participants</h2>
    				<ul class="add-links">
    					<li>
    						<a href="Delegation.jsp">Go to more Delegations-></a>
    					</li>
    				</ul>   
    			</header>
    			<ul class="related-list col6">
    			<% for(int i=0;i<team_pics.size();i++) {%><!-- delegation round pics and names -->
    			<%="<li>"+
    					"<div class='holder'>"+
    						"<a href=TeamDetailServlet?Event="+(java.net.URLEncoder.encode(eventName, "UTF-8")).replace("+", "%20")+"&delegation="+(java.net.URLEncoder.encode(team_pics.get(i).getDelegation_name(), "UTF-8")).replace("+", "%20")+">"+
    							"<picture class='image'>"+
    								"<img src=" + team_pics.get(i).getPath() + " alt=" + team_pics.get(i).getDelegation_name() +">"+
    							"</picture>"+
    						"</a>" +
    						"<a href=TeamDetailServlet?Event="+(java.net.URLEncoder.encode(eventName, "UTF-8")).replace("+", "%20")+"&delegation="+(java.net.URLEncoder.encode(team_pics.get(i).getDelegation_name(), "UTF-8")).replace("+", "%20")+">"+
							"<strong class='name'>" + team_pics.get(i).getDelegation_name() + "</strong>"+
    						"</a>"+
    					"</div>"+
    				"</li>" %>
    				<% } %>
    			</ul>
    		</section>
    	</div>
    	
    	<div class="result">
    	<h4>Click the table head to sort</h4>
    	<% for(int i=0;i<schedule.size();i++) {%>
    	<%="<section class='table-box'>"+
         		"<header class='heading'>"+
         				"<div style='float:left;'>" + "<text>"+schedule.get(i).getState()+"</text>" + "</div>"+
         				"<div style='margin-left:400px;'>" + "<text> Date:"+schedule.get(i).getDate()+"</text>" + "</div>"+
         		"</header>"+
         		"<table class='table4'>"+
         			"<caption class='hide'>Table</caption>"+
         			"<thead>"+
         				"<tr class='th-row'>"+
         					"<th class='col1'>Rank</th>"+
         					"<th class='col2'>Delegation</th>"+
         					"<th class='col3'>Grade</th>"+
         					"<th class='col4'>Notes</th>"+
         				"</tr>"+
         			"</thead>"+
         			"<tbody>" %>
         			<% team_results = reDao.getTeamResult(eventName, schedule.get(i).getState());%>
         			<% for(int j=0;j<team_results.size();j+=4){;%>
         			<%="<tr>"+
         					"<td class='col1'>"+
         						"<div class='medal'>"+
		                             "<span>"+team_results.get(j)+"<span/>"+//rank,delegation_name,path,grade
         						"</div>"+
         					"</td>"+
         					"<td class='col2'>"+
         						"<div class='profile-section'>"+
         								"<a href=TeamDetailServlet?Event="+(java.net.URLEncoder.encode(eventName, "UTF-8")).replace("+", "%20")+"&delegation="+team_results.get(j+1)+">"+
         							"<picture class='picture'>"+
         								"<img src='"+team_results.get(j+2)+"' alt='CHN'>"+//图片
         							"</picture>"+
         							"<div class='text-box'>"+
         								"<strong class='name'>"+team_results.get(j+1)+"</strong>"+//国家名字
         							"</div>"+
         							"</a>"+
         						"</div>"+
         					"</td>"+
         					         					
         					"<td class='col3' style='padding-left:10px;'>"+team_results.get(j+3)+"</td>"+//成绩
         					"<td class='col4'></td>"+
         				"</tr>" %>
         	<% } %>
         	<%="</tbody>"+
         		"</table>"+
         	 "</section>"%>
      	<% } %>

    	</div>
	</div>
    <!-- footer -->
    <div id="page-footer"></div>
 	</body>
 	<script type="text/javascript">
    $(".table4").tablesorter();
  </script>
</html>