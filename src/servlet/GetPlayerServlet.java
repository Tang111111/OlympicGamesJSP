package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdministratorDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class GetPlayerServlet
 */
@WebServlet("/GetPlayerServlet")
public class GetPlayerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPlayerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");
	    String eventName= request.getParameter("eventName");
	    String state= request.getParameter("state");

	    AdministratorDao administratorDao = new AdministratorDao();
	    List<String> players = administratorDao.getCurrentParticipant(eventName, state);//包含姓名和国家，大小是运动员个数的2倍

	    //包装成json对象，给前端传回json数组
	    JSONArray array=new JSONArray();
	    int playerIndex=0;
	    for (int counter = 0; counter < players.size() ;counter+=2) {
	    	 JSONObject temp=new JSONObject();
	    	 temp.put("name", players.get(counter));
	    	 temp.put("delegation", players.get(counter+1));
	    	 array.add(playerIndex,temp);
	    	 playerIndex++;
	    }
	    PrintWriter out=response.getWriter();
	    out.println(array);
	    out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
