<%@page language="java" import="java.util.*,dao.*,bean.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	
	<title>IndividualDetail</title>
	<link rel="stylesheet" type="text/css" href="css/style.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/styletwo.css"media="all"/>
	<link rel="stylesheet" type="text/css" href="css/chocolat.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/stylethree.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/result.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/headPicture.css" media="all" />
		
	<% DetailsDao detailsDao = new DetailsDao(); %>
	<% PictureDao pictureDao = new PictureDao(); %>
	<% String athleteName = request.getParameter("AthleteName");//Yang SUN %>
	<% Picture picture = detailsDao.getIndiTitle(athleteName); %>
	<% Medal medal = detailsDao.getIndiMedal(athleteName); %>
	<% Athlete athlete = detailsDao.getIndiInfo(athleteName); %>
	<% List<String> indiEvent = detailsDao.getIndiEvent(athleteName); %>
	<% List<History> indiHistory = detailsDao.getIndiHistory(athleteName); %>
	
	<style type="text/css">
		.chooseGame li {
			margin-top: 20px;
			list-style: none;
			margin-left: 50px;
			font-family: 'microsoft sans serif';
			color: #999999;
			font-size:1.1em ;
		}
	</style>
	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap3.0.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
	</script>
</head>

<body>

<!-- header -->
<div id="page-head"></div>

<section id="main">
	<article class="post hentry format-image">
		<header class="entry-header">
			<h2 class="entry-title"><%=athleteName %></h2>
			<div class="entry-meta">
				<a href=DelegationServlet?delegation=<%=picture.getDelegation_name() %>><img src="<%=picture.getPath() %>" width="30" /></a>
				<span class="sep"> | </span>
				<span class="cat-links"> <a href=DelegationServlet?delegation=<%=picture.getDelegation_name() %> ><%=picture.getDelegation_name() %></a></span>
			</div>
			<div class="entry-meta" style="margin-bottom:0px;">
				<picture class="picture">
					<img src="img/gold.png" width="20" alt="G">
				</picture>
				<text><%=medal.getGold() %></text>
				<span class="sep"> | </span>
				<picture class="picture">
					<img src="img/Silver.png" width="20" alt="S">
				</picture>
				<text><%=medal.getSilver() %></text>
				<span class="sep"> | </span>
				<picture class="picture">
					<img src="img/Bronze.png" width="20" alt="S">
				</picture>
				<text><%=medal.getBronze() %></text>
			</div>
		</header>
	</article>
	  <!-- banner -->
   <div class="headPicture">
	   <img src="<%=pictureDao.getAthleteCover(athleteName) %>" alt="First slide" width=100% style="margin-bottom:50px" />
   </div>
  

  <div class="col-md-4 top-grid" style="width:25%;margin-left: 150px;">
	  <h1><font color="mintcream">Born Date</font></h1>
	  <h4 class="ser"><%=athlete.getBirthday() %></h4>
	  <p class="ser"></p>
  </div>		
  <div class="col-md-4 top-grid" style="width:25%"><a href=DelegationServlet?delegation=<%=picture.getDelegation_name() %>>
      <h1><font color="mintcream">COUNTRY</font></h1>
      <h4 class="ser"><%=athlete.getDelegation_name() %></h4>
	  <p class="ser"></p></a>
  </div>		
  <div class="col-md-4 top-grid" style="width:25%"><a href=SportsServlet?Sports=<%=athlete.getSports_name() %>>
	  <h1><font color="mintcream">SPORT</font></h1>
	  <h4 class="ser"><%=athlete.getSports_name() %></h4>
	  <p class="ser"></p></a>
  </div>
  <div class="clearfix"></div>
  <hr />

	<div style="margin-left: 10%;margin-right: 10%;">
		<article class="post hentry format-quote">
			<!-- .entry-header -->
			<header class="entry-header">
				<h2 class="entry-title">The man who makes history</h2>
			</header>
			<!-- .entry-content -->
			<div class="entry-content">
				<blockquote><%=athlete.getDescription() %> </blockquote>
			</div>
		</article>
	</div>
	
	<div style="margin-left:10%;margin-right: 10%">
        <header class="heading"style="margin-left: 30px; margin-bottom: 20px;">
	       <h2>Event</h2>
        </header>
        <div class="chooseGame">
          <% for(int i=0; i<indiEvent.size();i++){ %>
          <%="<li>" +
			   "<div>" +
        		   "<text>" + indiEvent.get(i) + "</text>" +
			   "</div>" +
            "</li>" %>
          <% } %>
	    </div>
	
	<div  class="result" >
		  <section class="table-box">
		       <header class="heading" style="margin-left: 30px; margin-top: 40px;" >
		          <h2>BEST HISTORY</h2>
	           </header>
			   <table class="table4" style="margin-left: 30px;">
					<caption class="hide">Table</caption>
					<tr class="th-row">
						<th class="col1">Rank</th>
						<th class="col2">Game</th>
						<th class="col3">Event</th>
						<th class="col4">Grade</th>
					</tr>
					<tbody>
					   <% for(int i=0;i<indiHistory.size();i++){ %>
					   <%="<tr>" +
					         "<td class='col1'>" + indiHistory.get(i).getRank() + "</td>" +
					         "<td class='col2'>" + indiHistory.get(i).getGame() + "</td>" +
					         "<td class='col3'>" + indiHistory.get(i).getEvent_name() + "</td>" +
					         "<td class='col4'>" + indiHistory.get(i).getGrade() + "</td>" + 
					      "</tr>" %>
					   <% } %>
					</tbody>
				</table>
		  </section>
	</div>
</div>
	

<!-- footer -->
<div class="holder"></div>
<div id="page-footer"></div>

</body>
</html>