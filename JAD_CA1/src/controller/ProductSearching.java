package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SqlProductSearch;

/**
 * Servlet implementation class ProductSearching
 */
@WebServlet("/ProductSearching")
public class ProductSearching extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductSearching() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setAttribute("getallCat", new SqlProductSearch().getCategoryResult());
		request.getRequestDispatcher("test.jsp").include(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String getCategoryfromindex = request.getParameter("category");
		String getSearchfromindex = request.getParameter("stall-name");
	
		
		String getSearch = request.getParameter("SearchProcessing");
		String getCatid = request.getParameter("optradio");
		
		//System.out.print("GETING SEARCH: " + getSearch);
		//System.out.print("GETING GETCAID: " + getCatid);
		
		request.setAttribute("getallCat", new SqlProductSearch().getCategoryResult());
		
		request.setAttribute("Findallwithsearchandcatid", new SqlProductSearch().getListofProductWithName(getSearch, getCatid,getSearchfromindex, getCategoryfromindex));
		
		request.getRequestDispatcher("productlist-processing.jsp").include(request, response);
		
	}

}
