package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DelegationDao;
import dao.PictureDao;
import bean.Medal;
import bean.Picture;

/**
 * Servlet implementation class DelegationServlet
 */
@WebServlet("/DelegationServlet")
public class DelegationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DelegationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String delegationName = (String) request.getParameter("delegation");//get country name USA
		DelegationDao deleDao = new DelegationDao();
		Picture picture = deleDao.getDelegationInfo(delegationName);//里面有name和flag path
		Medal medal = deleDao.getMedal(delegationName);//medal list
		
		List<String> names = deleDao.getDelegationNames();
		if(names.contains(delegationName)){
			request.setAttribute("pictureBean",picture);
			request.setAttribute("medalBean",medal);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/DelegationDetail.jsp");
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
