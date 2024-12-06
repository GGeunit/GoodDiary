package Diary;

import java.io.IOException;
import java.util.List;

import user.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns={"/Diary"})
public class DiaryController extends HttpServlet {

    private DiaryDAO dao; // 데이터 접근 객체
    private DiaryService diaryService = new DiaryService();
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
                case "analyze":
                    analyze(request, response);
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
        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            // 로그인 상태가 아니면 로그인 페이지로 리다이렉트
            response.sendRedirect("/GoodDiary/user/login.jsp?error=notLoggedIn");
            return;
        }

        // 현재 사용자의 userId로 다이어리 목록 가져오기
        int userId = currentUser.getUserId();
        List<Diary> diaries = dao.getDiariesByUserId(userId);
//        List<Diary> diaries = dao.getAllDiaries();
        // 요청에 다이어리 목록을 속성으로 추가
        request.setAttribute("diaries", diaries);

        // JSP로 포워드
        RequestDispatcher dispatcher = request.getRequestDispatcher("Diary/diaryListPage.jsp");
        dispatcher.forward(request, response);
    }

    // View a single diary entry
    private void viewDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int recordId = Integer.parseInt(request.getParameter("id")); // "id"를 받아서 처리
        Diary diary = dao.getDiaryById(recordId);
        request.setAttribute("diary", diary);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Diary/viewDiaryPage.jsp");
        dispatcher.forward(request, response);
    }

    // Add a new diary entry
    private void addDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Diary diary = new Diary();
        diary.setTitle(request.getParameter("title"));
        diary.setDate(request.getParameter("date"));
        diary.setContent(request.getParameter("content"));
        diary.setAid(Integer.parseInt(request.getParameter("user_id")));
        
        
        double emotionScore = diaryService.emotionAnalyze(diary.getContent());
        String emotionLevel = mapScoreToEmotion(emotionScore);
        
        diary.setEmotion(emotionLevel); // 감정 필드 추가
        diary.setEmotionScore(emotionScore);
        
        System.out.println("현재 내용 감정 : " + emotionLevel);
        
        dao.addDiary(diary);
        response.sendRedirect("Diary?action=list");
    }

    // Delete a diary entry
    private void deleteDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int recordId = Integer.parseInt(request.getParameter("id"));
        dao.deleteDiary(recordId);
        response.sendRedirect("Diary?action=list");
    }
    
    
    
	// 점수를 감정 단계로 매핑
	private String mapScoreToEmotion(Double score) {
	    if (score == null) {
	        return "Unknown";
	    } else if (score >= 0.6) {
	        return "Very Positive"; // 매우 긍정적
	    } else if (score >= 0.2) {
	        return "Positive"; // 긍정적
	    } else if (score >= -0.2) {
	        return "Neutral"; // 중립적
	    } else if (score >= -0.6) {
	        return "Negative"; // 부정적
	    } else {
	        return "Very Negative"; // 매우 부정적
	    }
	}

	
	private void analyze(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            // 로그인 상태가 아니면 로그인 페이지로 리다이렉트
            response.sendRedirect("/GoodDiary/user/login.jsp?error=notLoggedIn");
            return;
        }

        // 현재 사용자의 userId로 다이어리 목록 가져오기
        int userId = currentUser.getUserId();
	    String startDate = request.getParameter("start_date"); // 요청에서 시작 날짜 가져오기
	    String endDate = request.getParameter("end_date"); // 요청에서 종료 날짜 가져오기

	    // 지정된 기간의 다이어리 가져오기
	    List<Diary> diaries = dao.getDiariesByDateRange(userId, startDate, endDate);

	    // 감정 점수 평균 계산
	    double totalScore = 0.0;
	    int count = diaries.size();
	    for (Diary diary : diaries) {
	        totalScore += diary.getEmotionScore();
	    }
	    double averageScore = count > 0 ? totalScore / count : 0.0;

	    // 결과를 요청 속성에 추가
	    request.setAttribute("diaries", diaries);
	    request.setAttribute("averageScore", averageScore);
	    request.setAttribute("startDate", startDate);
	    request.setAttribute("endDate", endDate);

	    // 분석 결과를 보여줄 JSP로 포워드
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/analyze/result.jsp");
	    dispatcher.forward(request, response);
	}

    
}
