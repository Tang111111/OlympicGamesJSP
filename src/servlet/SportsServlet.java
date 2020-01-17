package servlet;


import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Event;
import bean.Sports;
import dao.SportsDao;

/**
 * Servlet implementation class SportsServlet
 */
@WebServlet("/SportsServlet")
public class SportsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SportsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String sportName=request.getParameter("Sports");//swimming
		System.out.println(sportName);
		SportsDao sportsDao = new SportsDao();
		
		List<String> names = sportsDao.getSportsNames();
		if(names.contains(sportName)){
			RequestDispatcher dispatcher = request.getRequestDispatcher("/SportsDetail.jsp");
			dispatcher.forward(request, response);
		}
		else {
			response.getWriter().print("<script type='text/javascript'>alert('no data in database!')</script>");
			response.getWriter().print("<script type='text/javascript'>history.back()</script>"); //go back to last page
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
