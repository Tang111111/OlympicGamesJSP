package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Athlete;
import bean.Event;
import dao.AdministratorDao;

/**
 * Servlet implementation class InsertCompetionServlet
 */
@WebServlet("/InsertCompetionServlet")
public class InsertCompetionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertCompetionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String eventName=request.getParameter("Event");
		String sport=request.getParameter("Sports");
		String type=request.getParameter("type");
		String priDate=request.getParameter("priDate");
		String semiDate=request.getParameter("semiDate");
		String finDate=request.getParameter("finDate");
		String[] athlete=request.getParameterValues("athlete");
		String[] sex=request.getParameterValues("sex");
		String[] delegation=request.getParameterValues("delegation");
		String[] birthday=request.getParameterValues("birthday");
		Event notStart=new Event();
		notStart.setEvent_name(eventName);
		notStart.setSports_name(sport);
		notStart.setState("NOT STARTED");
		notStart.setType(type);
		Event priEvent=new Event();
		priEvent.setDate(priDate);
		priEvent.setEvent_name(eventName);
		priEvent.setSports_name(sport);
		priEvent.setState("priliminary");
		priEvent.setType(type);
		Event semiEvent=new Event();
		semiEvent.setDate(semiDate);
		semiEvent.setEvent_name(eventName);
		semiEvent.setSports_name(sport);
		semiEvent.setState("semifinal");
		semiEvent.setType(type);
		Event finEvent=new Event();
		finEvent.setDate(finDate);
		finEvent.setEvent_name(eventName);
		finEvent.setSports_name(sport);
		finEvent.setState("final");
		finEvent.setType(type);
		AdministratorDao adminDao=new AdministratorDao();
		adminDao.addEvent(priEvent);
		adminDao.addEvent(semiEvent);
		adminDao.addEvent(finEvent);
		
		
		for (int i=0;i<athlete.length;i++){
			Athlete newAthlete=new Athlete();
			newAthlete.setAthlete_name(athlete[i]);
			newAthlete.setBirthday(birthday[i]);
			newAthlete.setDelegation_name(delegation[i]);
			newAthlete.setSex(sex[i]);
			newAthlete.setSports_name(sport);
			adminDao.addAthletes(newAthlete);
		}
		
		response.getWriter().print("<script type='text/javascript'>alert('insert competition successfully!')</script>");
		response.getWriter().print("<script type='text/javascript'>history.back()</script>"); //go back to last page
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
