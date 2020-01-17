package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdministratorDao;

/**
 * Servlet implementation class JumpServlet
 */
@WebServlet("/JumpServlet")
public class JumpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JumpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		AdministratorDao adminDao=new AdministratorDao(); 
	    //String type=adminDao.getType(userName, eventName);
		String eventName = request.getParameter("Event");
		String sportName = request.getParameter("Sports");
		request.setAttribute("Event", eventName.replace(" ","%20" ));
		System.out.println(eventName);
		String type=adminDao.getType(sportName, eventName);
		
		if(type.toUpperCase().equals("TEAM")){
			RequestDispatcher dispatcher=request.getRequestDispatcher("/TeamServlet");
			dispatcher.forward(request, response);
		}else{
			RequestDispatcher dispatcher=request.getRequestDispatcher("/IndividualServlet");
			dispatcher.forward(request, response);
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
