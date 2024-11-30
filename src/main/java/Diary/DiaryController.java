package Diary;

import java.io.IOException;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns={"/Diary"})
public class DiaryController extends HttpServlet {

	private DiaryDAO dao;
	private ServletContext ctx;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		dao = new DiaryDAO();
		ctx = getServletContext();
	}
	
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		
    }
}
	