package user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 사용자 입력 값 가져오기
        String username = request.getParameter("username");
        String password = request.getParameter("password");

//        // 사용자 인증
//        if (userDAO.authenticate(username, password)) {
//            // 인증 성공 -> 세션 생성 및 사용자 정보 저장
//            HttpSession session = request.getSession();
//            session.setAttribute("username", username);
//
//            // 대시보드 또는 메인 페이지로 리다이렉트
//            response.sendRedirect("diary.nhn?action=listDiary");
//        } else {
//            // 인증 실패 -> 에러 메시지와 함께 로그인 페이지로 포워딩
//            request.setAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다!");
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//        }
    }
}
