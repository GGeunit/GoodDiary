package Diary;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/Diary"})
public class DiaryController extends HttpServlet {

    private DiaryDAO dao; // 데이터 접근 객체
    private ServletContext ctx;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        dao = new DiaryDAO();
        ctx = getServletContext();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "list"; // 기본 액션
            }

            switch (action) {
                case "list":
                    listDiaries(request, response);
                    break;
                case "view":
                    viewDiary(request, response);
                    break;
                case "delete":
                    deleteDiary(request, response);
                    break;
                default:
                    listDiaries(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ctx.log("Error processing GET request: " + action);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addDiary(request, response);
                    break;
                case "edit":
                    editDiary(request, response);
                    break;
                default:
                    response.sendRedirect("Diary?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ctx.log("Error processing POST request: " + action);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred.");
        }
    }

    // List all diary entries
    private void listDiaries(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Diary> diaries = dao.getAllDiaries();
        request.setAttribute("diaries", diaries);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Diary/diaryListPage.jsp");
        dispatcher.forward(request, response);
    }

    // View a single diary entry
    private void viewDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int recordId = Integer.parseInt(request.getParameter("id")); // "id"를 받아서 처리
        Diary diary = dao.getDiaryById(recordId);
        request.setAttribute("diary", diary);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Diary/diaryPage.jsp");
        dispatcher.forward(request, response);
    }

    // Add a new diary entry
    private void addDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Diary diary = new Diary();
        diary.setTitle(request.getParameter("title"));
        diary.setDate(request.getParameter("date"));
        diary.setEmotion(request.getParameter("emotion")); // 감정 필드 추가
        diary.setContent(request.getParameter("content"));
        diary.setAid(Integer.parseInt(request.getParameter("user_id")));

        dao.addDiary(diary);
        response.sendRedirect("Diary?action=list");
    }

    // Edit an existing diary entry
    private void editDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int recordId = Integer.parseInt(request.getParameter("id"));

        Diary diary = new Diary();
        diary.setAid(recordId); // VO의 `aid` 필드에 맞춤
        diary.setTitle(request.getParameter("title"));
        diary.setDate(request.getParameter("date"));
        diary.setEmotion(request.getParameter("emotion")); // 감정 필드 추가
        diary.setContent(request.getParameter("content"));

        dao.updateDiary(diary);
        response.sendRedirect("Diary?action=list");
    }

    // Delete a diary entry
    private void deleteDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int recordId = Integer.parseInt(request.getParameter("id"));
        dao.deleteDiary(recordId);
        response.sendRedirect("Diary?action=list");
    }
}
