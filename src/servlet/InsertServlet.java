package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Result;
import dao.ResultDao;

/**
 * Servlet implementation class InsertServlet
 */
@WebServlet("/InsertServlet")
public class InsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String event=request.getParameter("Event");
		System.out.println(event);
		String sport=request.getParameter("Sports");System.out.println(sport);
		String state=request.getParameter("state");System.out.println(state);
		String[] athlete=request.getParameterValues("athlete");System.out.println(athlete.length);
		String[] delegation=request.getParameterValues("delegation");
		String[] grade=request.getParameterValues("grade");
		String[] rank=request.getParameterValues("rank");
		System.out.println(event+" "+sport+" "+state+" "+athlete.length+" "+delegation.length+" "+grade.length+" "+rank.length);
		for(int i=0;i<athlete.length;i++){
			Result newResult=new Result();
			newResult.setEvent_name(event);
			newResult.setSports_name(sport);
			newResult.setState(state);
			newResult.setDelegation_name(delegation[i]);
			newResult.setGrade(grade[i]);
			newResult.setRank(Integer.parseInt(rank[i]) );
			newResult.setName(athlete[i]);
			ResultDao result=new ResultDao();
			result.addResult(newResult, event);
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
