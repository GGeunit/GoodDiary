package user;

import java.io.IOException;
import java.sql.SQLException;

import Diary.DiaryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if(action != null) {
			switch(action) {
				case "addUser":
					addUser(request, response);
					break;
				default:
					response.sendRedirect("signup.jsp?error=invalidAction");
			}
		}
		else {
			response.sendRedirect("signup.jsp?error=missingAction");
		}
		
	}
	
	public String addUser(HttpServletRequest request, HttpServletResponse response) {
		User user = new User();
		
		return null;
	}
}
