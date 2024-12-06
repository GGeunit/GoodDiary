package Diary;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

public class DiaryService {
	private static final int MAX_TEXT_LENGTH = 200; // 일기 최대 길이 설정

	// 감정 분석 메서드
	public double emotionAnalyze(String text) throws IOException {
		
	    // 텍스트 앞뒤 공백 및 개행 문자 제거
	    text = text.trim();
	    
	    // 텍스트 길이 검증
	    if (text.length() > MAX_TEXT_LENGTH) {
	        throw new IllegalArgumentException("분석 가능한 텍스트는 최대 " + MAX_TEXT_LENGTH + "자입니다.");
	    }

	    // 감정 분석 API URL
	    String sentimentApiUrl = "http://appledolphin.xyz:6000/analyze-sentiment";

	    // 요청 데이터 생성 (JSON 형식)
	    String jsonInput = String.format("{\"text\": \"%s\"}", text);

	    // HTTP 연결 설정
	    HttpURLConnection connection = (HttpURLConnection) new URL(sentimentApiUrl).openConnection();
	    connection.setRequestMethod("POST");
	    connection.setRequestProperty("Content-Type", "application/json; utf-8");
	    connection.setRequestProperty("Accept", "application/json");
	    connection.setDoOutput(true);

	    // 요청 본문 전송
	    try (OutputStream os = connection.getOutputStream()) {
	        byte[] input = jsonInput.getBytes(StandardCharsets.UTF_8);
	        os.write(input, 0, input.length);
	    }

	    // 응답 처리
	    int responseCode = connection.getResponseCode();
	    try {
	        if (responseCode == HttpURLConnection.HTTP_OK) {
	            // 성공적인 응답 처리
	            try (var inputStream = connection.getInputStream()) {
	                String response = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);

	                // JSON 파싱
	                ObjectMapper mapper = new ObjectMapper();
	                Map<String, Object> responseMap = mapper.readValue(response, Map.class);

	                // 감정 분석 결과 추출
	                Double score = (Double) responseMap.get("score");
	                
	                // 소수점 1자리로 반올림
	                score = Math.round(score * 10) / 10.0;
	                
	                // 감정 분석 결과 반환
	                System.out.println(String.format("Emotion Score: %.2f", score));
	                return score;
//	                return emotionLevel;
	            }
	        } else {
	            // 에러 응답 처리
	            try (var errorStream = connection.getErrorStream()) {
	                String errorResponse = new String(errorStream.readAllBytes(), StandardCharsets.UTF_8);
	                throw new IOException("감정 분석 실패: HTTP " + responseCode + " - " + errorResponse);
	            }
	        }
	    } finally {
	        connection.disconnect(); // 연결 해제
	    }
	}
}
