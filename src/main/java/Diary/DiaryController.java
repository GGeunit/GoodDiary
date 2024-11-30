package Diary;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/diary.nhn")
@MultipartConfig(maxFileSize=1024*1024*2, location="c:/Temp/img")
public class DiaryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DiaryDAO dao;
	private ServletContext ctx;
	
	// 웹 리소스 기본 경로 지정
	private final String START_PAGE = "Diary/diaryListPage.jsp";

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		dao = new DiaryDAO();
		ctx = getServletContext();
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		
		dao = new DiaryDAO();
		
		// 자바 리플렉션을 사용해 if, switch 없이 요청에 따라 구현 메서드가 실행되도록 함. 즉 action이름과 동일한 메서드를 호출
		// 리플렉션은 구체적인 클래스 타입을 모를때 사용
		Method m;
		String view = null;
		
		// action 파라미터 없이 접근한 경우
		if (action == null) {
			action = "listDiary";
		}
		
		try {
			// 현재 클래스에서 action 이름과 HttpServletRequest 를 파라미터로 하는 메서드 찾음
			m = this.getClass().getMethod(action, HttpServletRequest.class);
			
			// 메서드 실행후 리턴값 받아옴
			view = (String)m.invoke(this, request);
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
			// 에러 로그를 남기고 view 를 로그인 화면으로 지정, 앞에서와 같이 redirection 사용도 가능.
			ctx.log("요청 action 없음!!");
			request.setAttribute("error", "action 파라미터가 잘못 되었습니다!!");
			view = START_PAGE;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// POST 요청 처리후에는 리디렉션 방법으로 이동 할 수 있어야 함.
		if(view.startsWith("redirect:/")) {
			// redirect:/ 문자열 이후 경로만 가지고 옴
			String rview = view.substring("redirect:/".length());
			response.sendRedirect(rview);
		} else {
			// 지정된 뷰로 포워딩, 포워딩시 컨텍스트경로는 필요없음.
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}
	}
	
	public String addDiary(HttpServletRequest request) {
	    Diary n = new Diary();
	    try {
	        // 이미지 파일 저장
	        Part part = request.getPart("file");
	        String fileName = getFilename(part);
	        if (fileName != null && !fileName.isEmpty()) {
	            part.write(fileName);
	            n.setImg("/img/" + fileName); // 이미지 파일 이름 설정
	        }

	        // request에서 파라미터를 직접 가져와 Diary 객체에 설정
	        n.setTitle(request.getParameter("title"));
	        n.setDate(request.getParameter("date"));
	        n.setContent(request.getParameter("content"));

	        // DAO를 통해 데이터베이스에 추가
	        dao.addDiary(n);
	    } catch (Exception e) {
	        e.printStackTrace();
	        ctx.log("일기 추가 과정에서 문제 발생!!");
	        request.setAttribute("error", "일기가 정상적으로 등록되지 않았습니다!!");
	        return listDiary(request);
	    }

	    return "redirect:/diary.nhn?action=listDiary";
	}


	public String listDiary(HttpServletRequest request) {
		List<Diary> list;
		try {
			list = dao.getAll();
			request.setAttribute("diarylist", list);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("일기 목록 생성 과정에서 문제 발생!!");
			request.setAttribute("error", "일기 목록이 정상적으로 처리되지 않았습니다!!");
		}
		return "Diary/diaryListPage.jsp";
	}
	
	public String getDiary(HttpServletRequest request) {
		int aid = Integer.parseInt(request.getParameter("aid"));
		try {
			Diary n = dao.getDiary(aid);
			request.setAttribute("diary", n);
		} catch (SQLException e) {
			e.printStackTrace();
			ctx.log("일기를 가져오는 과정에서 문제 발생!!");
			request.setAttribute("error", "일기를 정상적으로 가져오지 못했습니다!!");
		}
		return "Diary/diaryPage.jsp";
	}
	
	public String deleteDiary(HttpServletRequest request) {
		int aid = Integer.parseInt(request.getParameter("aid"));
		try {
			dao.delDiary(aid);
		} catch (SQLException e) {
			e.printStackTrace();
			ctx.log("일기 삭제 과정에서 문제 발생!!");
			request.setAttribute("error", "일기가 정상적으로 삭제되지 않았습니다!!");
			return listDiary(request);
		}
		return "redirect:/diary.nhn?action=listDiary";
	}
	
	public String editDiary(HttpServletRequest request) {
	    Diary n = new Diary();
	    try {
	        if ("GET".equalsIgnoreCase(request.getMethod())) {
	            int aid = Integer.parseInt(request.getParameter("aid"));
	            Diary existingDiary = dao.getDiary(aid);
	            request.setAttribute("diary", existingDiary);
	            return "Diary/diaryEditPage.jsp";
	        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
	            int aid = Integer.parseInt(request.getParameter("aid"));
	            n.setAid(aid);

	            // 파라미터로 Diary 객체의 필드를 직접 설정
	            n.setTitle(request.getParameter("title"));
	            n.setDate(request.getParameter("date"));
	            n.setContent(request.getParameter("content"));

	            // 이미지 파일 처리
	            Part part = request.getPart("file");
	            String fileName = getFilename(part);
	            if (fileName != null && !fileName.isEmpty()) {
	                part.write(fileName);
	                n.setImg("/img/" + fileName);
	            } else {
	                // 기존 Diary의 이미지를 유지
	                Diary existingDiary = dao.getDiary(aid);
	                n.setImg(existingDiary.getImg());
	            }

	            // DAO를 통해 데이터베이스에 수정
	            dao.editDiary(n);
	            return "redirect:/diary.nhn?action=listDiary";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        ctx.log("일기 수정 과정에서 문제 발생!!");
	        request.setAttribute("error", "일기가 정상적으로 변경되지 않았습니다!!");
	        return "Diary/diaryEditPage.jsp";
	    }
	    return "redirect:/diary.nhn?action=listDiary";
	}

	
	// multipart 헤더에서 파일이름 추출
	private String getFilename(Part part) {
		String fileName = null;
		// 파일이름이 들어있는 헤더 영역을 가지고 옴
		String header = part.getHeader("content-disposition");
		// part.getHeader -> form-data; name="img"; filename="사진5.jpg"
		System.out.println("Header => "+header);
		
		// 파일 이름이 들어있는 속성 부분의 시작위치를 가져와 쌍따옴표 사이의 값 부분만 가지고옴
		int start = header.indexOf("filename=");
		fileName = header.substring(start+10,header.length()-1);
		ctx.log("파일명:"+fileName);
		return fileName;
	}
	
}