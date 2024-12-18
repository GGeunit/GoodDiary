package Diary;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;

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
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred.");
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
                case "confirm":
                    confirmDiary(request, response);
                    break;
                default:
                    response.sendRedirect("Diary?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ctx.log("Error processing POST request: " + action);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred.");
            return;
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
        return;
    }

    // View a single diary entry
    private void viewDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int recordId = Integer.parseInt(request.getParameter("id")); // "id"를 받아서 처리
        Diary diary = dao.getDiaryById(recordId);
        request.setAttribute("diary", diary);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Diary/viewDiaryPage.jsp");
        dispatcher.forward(request, response);
    }

    private void addDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Diary diary = new Diary();
        diary.setTitle(request.getParameter("title"));
        diary.setDate(request.getParameter("date"));
        diary.setContent(request.getParameter("content"));
        diary.setAid(Integer.parseInt(request.getParameter("user_id")));

        // 감정 분석 실행
        double emotionScore = diaryService.emotionAnalyze(diary.getContent());
        String emotionLevel = mapScoreToEmotion(emotionScore);

        // 분석 결과를 일기 객체에 설정
        diary.setEmotionScore(emotionScore);
        diary.setEmotion(emotionLevel);


        // JSP로 데이터 전달
        request.setAttribute("diary", diary);

        // 결과 확인 페이지로 포워드
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Diary/addCheck.jsp");
        dispatcher.forward(request, response);
    }
    
    private void confirmDiary(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	Double emotionScore = Double.parseDouble(request.getParameter("emotionScore"));
    	
        Diary diary = new Diary();
        diary.setTitle(request.getParameter("title"));
        diary.setDate(request.getParameter("date"));
        diary.setContent(request.getParameter("content"));
        diary.setAid(Integer.parseInt(request.getParameter("user_id")));
        diary.setEmotionScore(emotionScore);
        
        
        String emotionLevel = mapScoreToEmotion(emotionScore);
        diary.setEmotion(emotionLevel);
        
        // DB에 저장
        dao.addDiary(diary);

        // 리스트 페이지로 리다이렉트
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
	    HttpSession session = request.getSession();
	    User currentUser = (User) session.getAttribute("user");

	    if (currentUser == null) {
	        response.sendRedirect("/GoodDiary/user/login.jsp");
	        return;
	    }

	    int userId = currentUser.getUserId();
	    String startDate = request.getParameter("startDate");
	    String endDate = request.getParameter("endDate");

	    // 날짜 범위에 따른 다이어리 가져오기
	    List<Diary> diaries = dao.getDiariesByDateRange(userId, startDate, endDate);
	    
	    // 평균 감정 점수 계산
	    double totalScore = 0.0;
	    int count = diaries != null ? diaries.size() : 0;
	    if (diaries != null) {
	        for (Diary diary : diaries) {
	            totalScore += diary.getEmotionScore();
	        }
	    }
	    double averageScore = count > 0 ? totalScore / count : 0.0;

	    // 분석 메시지 생성
	    String analysisMessage = generateAnalysisMessage(averageScore);
	    String imageName = getEmotionImageName(averageScore);
	    
	    // JSON 변환
	    Gson gson = new Gson();
	    String diariesJson = gson.toJson(diaries);

	    // JSP로 데이터 전달
	    request.setAttribute("diaries", diaries); // JSP에서 다이어리 데이터 사용
	    request.setAttribute("diariesJson", diariesJson); // 차트용 JSON 데이터
	    request.setAttribute("averageScore", averageScore);
	    request.setAttribute("startDate", startDate);
	    request.setAttribute("endDate", endDate);
	    request.setAttribute("analysisMessage", analysisMessage);
	    request.setAttribute("imageName", imageName);

	    // JSP로 포워드
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/analyze/result.jsp");
	    dispatcher.forward(request, response);
	    
	    return;
	}

	
	// 감정 점수에 따른 메시지 생성
	private String generateAnalysisMessage(double averageScore) {
	    if (averageScore >= 0.6) {
	        return "이 기간 동안 매우 긍정적인 감정을 느끼셨네요! 지금처럼 긍정적인 기운을 유지하세요!";
	    } else if (averageScore >= 0.2) {
	        return "대체로 긍정적인 감정을 느끼셨습니다. 행복을 주는 것들에 집중해 보세요.";
	    } else if (averageScore >= -0.2) {
	        return "감정이 대체로 중립적이네요. 하루를 더욱 보람차게 만들 수 있는 요소를 생각해보세요.";
	    } else if (averageScore >= -0.6) {
	        return "최근에 조금 우울한 기분이 드셨던 것 같아요. 충분한 휴식을 취하고 스스로를 돌보는 시간을 가져보세요.";
	    } else {
	        return "이 기간 동안 감정적으로 많이 힘드셨던 것 같아요. 자신을 잘 돌보고 필요하다면 도움을 요청하는 것을 고려해보세요.";
	    }
	}
	
	// 감정 점수에 따른 사진 이름 리턴
	private String getEmotionImageName(double averageScore) {
	    if (averageScore >= 0.6) {
	        return "smile.jpg";
	    } else if (averageScore >= 0.2) {
	        return "smile.jpg";
	    } else if (averageScore >= -0.2) {
	        return "neutral.jpg";
	    } else if (averageScore >= -0.6) {
	        return "bad.jpg";
	    } else {
	        return "bad.jpg";
	    }
	}


    
}
