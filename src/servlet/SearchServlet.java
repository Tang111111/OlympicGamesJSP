package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.javafx.binding.StringFormatter;

import dao.AdministratorDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;


/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		response.setCharacterEncoding("UTF-8");
       String sportsName= request.getParameter("SportsName");
        System.out.println(sportsName+"**********");
       JSONArray array=new JSONArray();
       JSONObject temp1=new JSONObject();
       AdministratorDao administratorDao = new AdministratorDao();
       List<String> list = administratorDao.getAllEvents(sportsName);
      
       try {
           
    	   for(int i=0;i<list.size();i++){
        	   temp1.put("event_name", list.get(i));  
        	   array.add(i,temp1);
           }
       } catch (JSONException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }

       //向前台的页面输出结果
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
