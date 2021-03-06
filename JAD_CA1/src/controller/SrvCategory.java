package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.SqlProductSearch;
import model.*;

/**
 * Servlet implementation class SrvCategory
 */
@WebServlet("/Product")
public class SrvCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SrvCategory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		request.setAttribute("getallCat", new SqlProductSearch().getCategoryResult());
		request.setAttribute("getallProducts", new SqlProductSearch().getListofProduct());
		
		request.getRequestDispatcher("productlist.jsp").include(request, response);
		//response.sendRedirect("test.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		//String getSearch = request.getParameter("SearchProcessing");
		//String getCatid = request.getParameter("optradio");
		
		//request.setAttribute("Findallwithsearchandcatid", new SqlProductSearch().getListofProductWithName(getSearch, getCatid));
		
		//request.getRequestDispatcher("productlist.jsp").include(request, response);
		
	}

}
