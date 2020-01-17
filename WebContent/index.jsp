<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page language="java" import="java.util.*,dao.*,bean.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Olympic Games-Home Page</title>
	<script src="js/jquery.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
	</script>
	<link rel="stylesheet" type="text/css" href="css/homepage.css">

</head>
<%PictureDao pictures=new PictureDao();
	List<String> getPicturesForBroadcast=pictures.getHomeGallery();
%>
<jsp:useBean id="medalBean" class="bean.Medal" scope="page"/>
<body>
<!-- header -->
<div id="page-head"></div>

<!-- banner -->
<div id="myCarousel" class="carousel slide">
	<!-- Carousel indicators-->
	<ol class="carousel-indicators">
		
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
		<li data-target="#myCarousel" data-slide-to="3"></li>
		<li data-target="#myCarousel" data-slide-to="4"></li>
	</ol>
	<!-- Carousel items -->
	<div class="carousel-inner">
		<div class="item active">
			<img src="img/slider1.jpg" alt="First slide">
			<div class="carousel-caption">100M MEN FREESTROKE JUST FINNISHED</div>
		</div>
		<div class="item">
			<img src="img/slider2.jpg" alt="Second slide">
			<div class="carousel-caption">YOUNG EMILY STARK WINS HER FIRST GOLD MEDAL</div>
		</div>
		<div class="item">
			<img src="img/slider3.jpg" alt="Third slide">
			<div class="carousel-caption">JOHNNY JAMES:<br>5 YEARS ON THE ROAD AND STILL RUNNING</div>
		</div>
		<div class="item">
			<img src="img/slider4.jpg" alt="Third slide">
			<div class="carousel-caption">CHECK OUT OUR INTERVIEW <br>WITH 3-TIME WINNER BOB WILLIAMS</div>
		</div>
		<div class="item">
			<img src="img/slider5.jpg" alt="Third slide">
			<div class="carousel-caption">CALM AND STEADY: <br>OLYMPIC WINNER AND RISING STAR LIN</div>
		</div>
	</div>
	<!-- Carousel left and right navigation-->
	<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</a>
	<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</a>
</div>

<!-- medal table header -->
<div class="medal-table-header">
			<span class="medal-table-header-content">
				real time medal record
			</span>
</div>

<%	DelegationDao deleDao=new DelegationDao();
	List<String> getAllDelegationNames=deleDao.getDelegationNames();
%>
<!-- medal table -->
<div class="real-time-record">
	<ul class="medal-table">
	<%for(int i=0;i<getAllDelegationNames.size();i++){%>
	<%medalBean=deleDao.getMedal(getAllDelegationNames.get(i)); %>
		<%="<li class='country-block'>"+
		"<div class='country-name'>"+
			"<div class='country-figure'>"+
				"<span class='country'><a href=DelegationServlet?delegation="+getAllDelegationNames.get(i)+">"+getAllDelegationNames.get(i)+"</a></span>"+
			"</div>"+
		"</div>"+
		"<ul class='details'>"+
			"<li>"+medalBean.getGold()+" Gold</li>"+
			"<li>"+medalBean.getSilver()+" Silver</li>"+
			"<li>"+medalBean.getBronze()+" Bronze</li>"+
		"</ul>"+
		"<div class='medal-total'>"+
			"<div class='action_button'>"+(int)(medalBean.getGold()+medalBean.getSilver()+medalBean.getBronze())+"  Total</div>"+
		"</div>"+
	"</li>"  %>
	<%} %>
	</ul>
</div>


<!-- tab menu -->
<div class='container-fluid'>
	<h2 class='page-header'></h2>
	<div class="tabbable tabs-left">
		<!-- tabs -->
		<ul class='nav nav-tabs'>
			<li class='active'><a href='#tab1' data-toggle='tab'>ALL ABOUT THE GAMES</a></li>
			<li><a href='#tab2' data-toggle='tab'>MOSCOT</a></li>
			<li><a href='#tab3' data-toggle='tab'>TORCH</a></li>
			<li><a href='#tab4' data-toggle='tab'>MEDALS</a></li>
			<li><a href='#tab5' data-toggle='tab'>TICKETS</a></li>
		</ul>

		<!-- tab content -->
		<div class='tab-content'>
			<div class='tab-pane active' id='tab1'>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				<br><br><img src="img/13-08-2016-swimming-50m-freestyle-women-02.jpg" style="max-width: 75%;"/>
				<h6>Photo by google, all rights reserved.</h6>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
			</div>
			<div class='tab-pane' id='tab2'>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.

			</div>
			<div class='tab-pane' id='tab3'>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
			</div>
			<div class='tab-pane' id='tab4'>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				<br><br><img src="img/Swimming_sidebar.jpg" style="max-width: 75%;"/>
				<h6>Photo by google, all rights reserved.</h6>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
				Named after one of Brazil’s most prominent 20th century cultural icons,
				Vinicius des Moraes, the mascot for the Olympic Games Rio 2016 constitutes
				a blend of animals native to Brazil,
				and symbolises the energy and joie de vivre exuded by the Brazilian people.
			</div>
			<div class='tab-pane' id='tab5'><br>Sorry, tickets are sold out!</div>
		</div>
	</div>

</div>

<!-- footer -->
<div class="holder"></div>
<div id="page-footer"></div>
</body>
</html>