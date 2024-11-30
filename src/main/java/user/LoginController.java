package user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUDI = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String name = request.getParameter("name");
    	String password = request.getParameter("password");
    	
    	UserDAO userDao = new UserDAO();
    	try {
    		User user = userDao.login(name, password);
    		if(user != null) {
    			HttpSession session = request.getSession();
    			session.setAttribute("user", user);
    			response.sendRedirect("/GoodDiary/Diary/diaryListPage.jsp");
    		}
    		else {
    			response.sendRedirect("/GoodDiary/user/login.jsp?error=invalidCredentials");
    		}
    	} catch (SQLException e) {
    		e.printStackTrace();
    		response.sendRedirect("/GoodDiary/user/login.jsp?error=serverError");
    	}
    }
    


}
