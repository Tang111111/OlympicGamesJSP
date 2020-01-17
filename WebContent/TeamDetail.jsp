<%--
  Created by IntelliJ IDEA.
  User: 唐玮瑶
  Date: 2018/7/5
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" import="java.util.*,dao.*,bean.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html lang="en-US" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=devimyce-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>TeamDetail</title>
    <link rel="stylesheet" type="text/css" href="css/style.css" media="all" />
    <link rel="stylesheet" type="text/css" href="css/styletwo.css"media="all"/>
    <link rel="stylesheet" type="text/css" href="css/chocolat.css" media="all" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" media="all" />
    <link rel="stylesheet" type="text/css" href="css/stylethree.css" media="all" />
    <link rel="stylesheet" type="text/css" href="css/result.css" media="all" />
    <link rel="stylesheet" type="text/css" href="css/participant.css" media="all" />
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap3.0.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
    </script>
    
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
    
    <% DelegationDao delegationDao = new DelegationDao(); %>
    <% DetailsDao detailsDao=new DetailsDao(); %>
    <% PictureDao picturedao=new PictureDao(); %>
    <% String event_name=request.getParameter("Event"); %>
    <% String delegation_name=request.getParameter("delegation"); %>
    <% Picture team_info=detailsDao.getTeamTitle(delegation_name,event_name); %>
    <% String team_name=team_info.getDelegation_name(); %>
    <% List<Result> team_event=detailsDao.getTeamEvent(team_name); %>
    
    <% List<Result> team_event2 = detailsDao.getTeamEvent2(team_name); %>
    <% List<Picture> team_member=picturedao.getAllMember(team_name); %>
    <% List<History> team_history=detailsDao.getTeamHistory(team_name); %>
 
</head>

<body>

<!-- header -->
<div id="page-head"></div>

<section id="main">

    <table id="primary">
        <br id="content" role="main">

        <!-- begin article -->
        <article class="post hentry format-image">
            <header class="entry-header">
                <h2 class="entry-title"><font color="#00AEFF"></font><%=team_name%></h2>
                <div class="entry-meta">
                    <a href=DelegationServlet?delegation=<%=delegation_name%>><img src="<%=team_info.getPath() %> " width="30" /></a>
                    <span class="sep"> | </span>
                    <span class="cat-links"> <a href=DelegationServlet?delegation=<%=delegation_name%>><%=delegation_name %></a></span>
                </div>
                <div class="entry-meta" style="margin-bottom:0px;">
                    <picture class="picture">
                        <img src="img/gold.png" width="20" alt="G">
                        <span class="mask"></span>
                    </picture>
                    <%=detailsDao.getTeamMedal(team_name).getGold() %>
                    <span class="sep"> | </span>
                    <picture class="picture">
                        <img src="img/Silver.png" width="20" alt="S">
                        <span class="mask"></span>
                    </picture>
                    <%=detailsDao.getTeamMedal(team_name).getSilver() %>
                    <span class="sep"> | </span>
                    <picture class="picture">
                        <img src="img/Bronze.png" width="20" alt="S">
                        <span class="mask"></span>
                    </picture>
                    <%=detailsDao.getTeamMedal(team_name).getBronze() %>
                </div>
            </header>
        </article>

        <!-- banner -->
        <div class="headPicture">
	        <img src="<%=picturedao.getTeamCover(team_name) %>" alt="First slide" width=100% style="margin-bottom:50px;" />
        </div>
       
        <div class="col-md-4 top-grid" style="width:25%;margin-left: 150px;">
            <h1><font color="mintcream">Member</font></h1>
            <h4 class="ser"><%=detailsDao.getTeamInfo(team_name).get(0) %></h4>
            <p class="ser"></p>
        </div>
        <div class="col-md-4 top-grid" style="width:25%"><a href=DelegationServlet?delegation=<%=delegation_name%>>
            <h1><font color="mintcream">COUNTRY</font></h1>
            <h4 class="ser"><%=delegation_name %></h4>
            <p class="ser"></p></a>
        </div>
        <div class="col-md-4 top-grid" style="width:25%"><a href=SportsServlet?Sports=<%=detailsDao.getTeamInfo(team_name).get(1)%>>
            <h1><font color="mintcream">SPORT</font></h1>
            <h4 class="ser"><%=detailsDao.getTeamInfo(team_name).get(1) %></h4>
            <p class="ser"></p></a>
        </div>

        <div class="clearfix"></div>
        <hr />

        <div style="margin-left: 10%;margin-right: 10%;">
            <article class="post hentry format-quote">
                <header class="entry-header">
                    <h2 class="entry-title">Dream Team</h2>
                </header>
                <!-- .entry-header -->
                <div class="entry-content">
                    <blockquote><%=detailsDao.getTeamInfo(team_name).get(2) %></blockquote>
                </div><!-- .entry-content -->
            </article>
         </div>


        <!--==============================content================================-->

        <div style="margin-left:10%;margin-right: 10%">
            <header class="heading"style="margin-left: 30px; margin-bottom: 20px;">
                <h2>Event</h2>
            </header>
            <div class='chooseGame'>
            <% for(int i=0;i<team_event.size();i++){ %>
            <%= "<li>"+ 
                   "<div>" + 
                      "<div style='float:left;color:#696969;font-size:15px;font-weight:800;'>" +
                    	  "<text>" + team_event.get(i).getEvent_name() + "</text>" +
                      "</div>" +
                      "<div style='margin-left:500px;color:#696969;font-size:15px;font-weight:800;'>" +
                          "<text>" + team_event.get(i).getName() + "</text>" + 
                      "</div>" +
                      "<div style='padding-top:5px;'>" %>
                      <% List<Mem_position> team_position = detailsDao.getTeamPosition(team_name, team_event.get(i).getEvent_name()); %>
                      <%= "<text> Position: </text>" %>
                      <% for (int j=0;j<team_position.size();j++){ %>
                      <%="<text>" + team_position.get(j).getPosition() + "</text>" + "<text> &nbsp; </text>" +
                    	  "<text>" + team_position.get(j).getAthlete_name() + "<text> &nbsp;&nbsp;&nbsp; </text>" + "</text>" %>
                      <% } %>
             <%=  "</div>" +
                 "</div>" +
                "</li>" %>
            <% } %>
            
            <% for(int i=0;i<team_event.size();i++){ %>
            <%= "<li>"+ 
                   "<div>" + 
                      "<div style='float:left;color:#696969;font-size:15px;font-weight:800;'>" +
                    	  "<text>" + team_event2.get(i).getEvent_name() + "</text>" + 
                      "</div>" +
                      "<div style='margin-left:500px;color:#696969;font-size:15px;font-weight:800;'>" +
                          "<text>" + team_event2.get(i).getName() + "</text>" + 
                      "</div>" +
                    "</div>" +
                 "</li>" %>
             <% } %>
            </div>
            

            <!--==============================content-end================================-->
            <!--div id="controls"></div>
            <div class="slideshow-container">
                 <div id="slideshow" class="slideshow"></div-->



            <!-------------------------------------------introduction------------------------------------------------------------------------------->
                 <div class="participant">
                <section class="related-athletes alt first">
                    <header class="heading"style="margin-left: 30px; margin-bottom: 20px;">
                        <h2>STARS</h2>
                    </header>
                    <ul class="related-list col6">
                        <% for(int i=0;i<team_member.size();i++) {%><!-- delegation round pics and names -->
                        <%="<li>"+
                                "<div class='holder'>"+
                                "<a href=IndividualDetailServlet?AthleteName="+(java.net.URLEncoder.encode(team_member.get(i).getAthlete_name(),"UTF-8")).replace("+","%20")+">" +
                                "<picture class='image' style='width:180px;height:180px;' >"+
                                "<div>"+
                                "<img src=" + team_member.get(i).getPath() + ">"+
                                "</div>"+
                                "</picture>"+
                                "<div>"+
                                "<p><strong class='name'>"+team_member.get(i).getAthlete_name()+"</strong></p>"+
                                "</div>"+
                                "</a>" +
                                "</div>"+
                                "</li>" %>
                        <% } %>

                    </ul>
                </section>
            </div>
          

            <div  class="result">
                <section class="table-box" >
                    <header class="heading" style="margin-left: 30px;margin-bottom:0px;">
                        <h2>Best History</h2>
                    </header>
                    <table class="table4" style="margin-left:10%;margin-right:10%;">
                        <caption class="hide">Table</caption>
                        <thead>
                        <tr class="th-row">
                            <th class="col1">Rank</th>
                            <th class="col2">Game</th>
                            <th class="col3">Event</th>
                            <th class="col4">Grade</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for(int i=0;i<team_history.size();i++){ %>
                        <%="<tr>"+
                            "<td class='col1'>"+team_history.get(i).getRank() +"</td>"+
                             "<td class='col2'>"+team_history.get(i).getGame()+"</td>"+
                            "<td class='col3'>"+team_history.get(i).getEvent_name()+"</td>"+
                            "<td class='col4'>"+team_history.get(i).getGrade()+"</td>"+
                          "</tr>" %>
                        <% } %>
                        </tbody>
                    </table>
                </section>
            </div>
        </div>
        </tbody>

    </table>
    </div>


    <!-- footer -->
    <div class="holder"></div>
    <div id="page-footer"></div>
    
</section>
</body>
</html>


















