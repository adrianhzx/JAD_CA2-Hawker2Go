package servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.io.output.*;

/**
 * Servlet implementation class FileUpload
 */
@WebServlet("/FileUpload")
public class FileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUpload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(true);
		
		
		// Do not run out.print! or else Servlet will crash.
		String stallgetStoreID = (String)session.getAttribute("getStoreID");
		// Giving fileName as global, ltr need the values.
		String fileName = "";
		
		// Getting file from Input Html. And calling as File object.
		File file ;
		
		// Type of File and memory. Too much will error.
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 5000 * 1024;
		
		// Getting filepath value from web.xml
		String filePath = getServletContext().getInitParameter("file-upload");
		
		// Verify the content type
		String contentType = request.getContentType();
		
		// Checking if there is a file. No file straight to catch.
		if((contentType.indexOf("multipart/form-data") >= 0)) {
			// a method to get file.
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			  // maximum size that will be stored in memory
		      factory.setSizeThreshold(maxMemSize);
		      
		      // Location to save data that is larger than maxMemSize.
		      factory.setRepository(new File("c:\\temp"));

		      // Create a new file upload handler
		      ServletFileUpload upload = new ServletFileUpload(factory);
		      
		      // maximum file size to be uploaded.
		      upload.setSizeMax( maxFileSize );
		      try {
		    	  List fileItems = upload.parseRequest(request);
		          
		          // Process the uploaded file items
		          Iterator i = fileItems.iterator();

		          // starting html. DO NOT REMOVE!
		          out.println("<html>");
		          out.println("<head>");
		          out.println("<title>JSP File upload</title>");  
		          out.println("</head>");
		          out.println("<body>");
		          
		          while ( i.hasNext () ) {
		             FileItem fi = (FileItem)i.next();
		             if ( !fi.isFormField () ) {
		                // Get the uploaded file parameters
		                String fieldName = fi.getFieldName();
		                
		                // supposedly, fileName need to be global in order to get its value ltr.
		                fileName = fi.getName();
		                
		                //getting memory and file size
		                boolean isInMemory = fi.isInMemory();
		                long sizeInBytes = fi.getSize();
		             
		                // Write the file
		                if( fileName.lastIndexOf("\\") >= 0 ) {
		                   file = new File( filePath + 
		                   fileName.substring( fileName.lastIndexOf("\\"))) ;
		                } else {
		                   file = new File( filePath + 
		                   fileName.substring(fileName.lastIndexOf("\\")+1)) ;
		                }
		                     
		                fi.write( file ) ;
		                //out.println("Uploaded Filename: " + filePath + fileName + "<br>");		    
		                out.println("Loading image... Please Wait...");
		             }
		          }
		         // same for here. DO NOT REMOVE
		         out.println("</body>");
		         out.println("</html>");
		         out.println("<script type=\"text/javascript\">");		          
		 		 out.println("alert('Image has been uploaded!');");
		 		 // If there's storeID, it will be edit. Else create stall.
		 		 if(stallgetStoreID != null){
		 			 //This is for stall update.
		 			 //out.println("location='AdminUpdateAddStall.jsp?Storeid="+stallgetStoreID+"&getImgName="+fileName+" ';");
		 			 out.println("setInterval(function(){location='AdminUpdateAddStall.jsp?Storeid="+stallgetStoreID+"&getImgName="+fileName+" '; }, 3000);");
		 		 }else{
		 			 // this is create stall.
		 			 //out.println("location='AdminUpdateAddStall.jsp?getImgName="+fileName+" ';");
		 			out.println("setInterval(function(){location='AdminUpdateAddStall.jsp?getImgName="+fileName+" '; }, 3000);");
		 		 }
		 		 out.println("</script>");
		 		 // For edit, after we get the StoreID. throw away in case of duplicate or cannot be use again.
		 		 session.removeAttribute(stallgetStoreID);
				
			} catch (FileNotFoundException e) {
				// TODO: handle exception
				// No image, Will be returned.
				out.println("<script type=\"text/javascript\">");
		 		out.println("alert('Error! Please upload an images in order to modify!');");
		 		// If there's storeID, it will be edit. Else create stall.
		 		if (stallgetStoreID != null) {
		 			//This is for stall update.
		 			out.println("location='AdminUpdateAddStall.jsp?Storeid="+stallgetStoreID+"';");
				}else {
					 // this is create stall.
					out.println("location='AdminUpdateAddStall.jsp;");
				}
		 		out.println("</script>");
			}
		      
		      catch (Exception e) {
				// TODO: handle exception
				out.print(e);
			}
		}else {
			out.println("<html>");
		      out.println("<head>");
		      out.println("<title>Servlet upload</title>");  
		      out.println("</head>");
		      out.println("<body>");
		      out.println("<p>No file uploaded</p>"); 
		      out.println("</body>");
		      out.println("</html>");
		};
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
