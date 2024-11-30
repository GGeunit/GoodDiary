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
				try {
					addUser(request, response);
				} catch (SQLException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					response.sendRedirect("signup.jsp?error=databaseError");
				}
					break;
				default:
					response.sendRedirect("signup.jsp?error=invalidAction");
			}
		}
		else {
			response.sendRedirect("signup.jsp?error=missingAction");
		}
		
	}
	
	public void addUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
		String username = request.getParameter("name");
		String password = request.getParameter("password");
		
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		
		UserDAO userDAO = new UserDAO();
		userDAO.signup(user);
		
		request.setAttribute("message", "회원가입이 완료되었습니다.");
		request.getRequestDispatcher("/GoodDiary/user/login.jsp").forward(request, response);
	}
}
