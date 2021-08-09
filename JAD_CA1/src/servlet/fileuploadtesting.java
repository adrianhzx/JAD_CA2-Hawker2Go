package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.io.output.*;

/**
 * Servlet implementation class fileuploadtesting
 */
@WebServlet("/fileuploadtesting")
public class fileuploadtesting extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public fileuploadtesting() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		File file ;
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 5000 * 1024;
		
		
		String filePath = getServletContext().getInitParameter("file-upload");
		PrintWriter out = response.getWriter();
		/*
		 * PrintWriter out = response.getWriter(); try { ServletFileUpload sf = new
		 * ServletFileUpload(new DiskFileItemFactory());
		 * 
		 * List<FileItem> multifiles = sf.parseRequest(request);
		 * 
		 * for(FileItem item : multifiles) { item.write(new File(filePath +
		 * item.getName())); }
		 * 
		 * out.print("Pass!"); }catch(Exception e) { out.print(e); }
		 */
		
		String contentType = request.getContentType();
		if ((contentType.indexOf("multipart/form-data") >= 0)) {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemSize);
		factory.setRepository(new File("c:\\temp"));
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax( maxFileSize );
		try{
		List fileItems = upload.parseRequest(request);
		Iterator i = fileItems.iterator();
		while ( i.hasNext () )
		{
		FileItem fi = (FileItem)i.next();
		if ( !fi.isFormField () ) {
		String fieldName = fi.getFieldName();
		String fileName = fi.getName();
		boolean isInMemory = fi.isInMemory();
		long sizeInBytes = fi.getSize();
		file = new File( filePath + "yourFileName") ;
		fi.write( file ) ;
		out.println("Uploaded Filename: " + filePath + fileName + "<br>");
		}
		}
		}catch(Exception ex) {
		System.out.println(ex);
		}
		}else{
		out.println("Error in file upload.");
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
