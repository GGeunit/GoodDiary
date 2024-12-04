package Diary;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiaryDAO {
    final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    final String JDBC_URL = "jdbc:mysql://14.51.115.47:3309/GoodDiary";

    // DB 연결을 가져오는 메서드
    public Connection open() {
        Connection conn = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(JDBC_URL, "GoodDiary", "goodgood1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    // CREATE: 새로운 다이어리 추가
    public void addDiary(Diary diary) throws SQLException {
        String query = "INSERT INTO emotionRecord (user_id, title, date, emotion, content, emotion_score) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(query)) {
        	pstmt.setInt(1, diary.getAid());
            pstmt.setString(2, diary.getTitle());
            pstmt.setString(3, diary.getDate());
            pstmt.setString(4, diary.getEmotion());
            pstmt.setString(5, diary.getContent());
            pstmt.setDouble(6, diary.getEmotionScore());
            pstmt.executeUpdate();
        }
    }

    // READ ALL: 모든 다이어리 조회
    public List<Diary> getAllDiaries() throws SQLException {
        List<Diary> diaries = new ArrayList<>();
        String query = "SELECT * FROM emotionRecord order by date desc";
        try (Connection conn = open(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Diary diary = new Diary();
                diary.setAid(rs.getInt("record_id"));
                diary.setTitle(rs.getString("title"));
                diary.setDate(rs.getDate("date").toString());
                diary.setEmotion(rs.getString("emotion"));
                diary.setContent(rs.getString("content"));
                diaries.add(diary);
            }
        }
        return diaries;
    }

    // READ ONE: 특정 다이어리 조회
    public Diary getDiaryById(int aid) throws SQLException {
        String query = "SELECT * FROM emotionRecord WHERE record_id = ?";
        try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, aid);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Diary diary = new Diary();
                diary.setRecordId(rs.getInt("record_id"));
                diary.setAid(rs.getInt("user_id"));
                diary.setTitle(rs.getString("title"));
                diary.setDate(rs.getDate("date").toString());
                diary.setEmotion(rs.getString("emotion"));
                diary.setContent(rs.getString("content"));
                return diary;
            }
        }
        return null; // 해당 ID의 다이어리가 없으면 null 반환
    }

    // UPDATE: 다이어리 수정
    public void updateDiary(Diary diary) throws SQLException {
        String query = "UPDATE emotionRecord SET title = ?, date = ?, emotion = ?, content = ? WHERE record_id = ?";
        try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, diary.getTitle());
            pstmt.setString(2, diary.getDate());
            pstmt.setString(3, diary.getEmotion());
            pstmt.setString(4, diary.getContent());
            pstmt.setInt(5, diary.getAid());
            pstmt.executeUpdate();
        }
    }

    // DELETE: 다이어리 삭제
    public void deleteDiary(int aid) throws SQLException {
        String query = "DELETE FROM emotionRecord WHERE record_id = ?";
        try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, aid);
            pstmt.executeUpdate();
        }
    }
    
    public List<Diary> getDiariesByUserId(int userId) throws SQLException {
        List<Diary> diaries = new ArrayList<>();
        String sql = "SELECT * FROM emotionRecord WHERE user_id = ? order by date desc";

        try (Connection conn = open();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Diary diary = new Diary();
                    diary.setRecordId(rs.getInt("record_id"));
                    diary.setAid(rs.getInt("user_id"));
                    diary.setTitle(rs.getString("title"));
                    diary.setDate(rs.getString("date"));
                    diary.setEmotion(rs.getString("emotion"));
                    diary.setContent(rs.getString("content"));
                    diary.setEmotionScore(rs.getDouble("emotion_score"));
                    diaries.add(diary);
                }
            }
        } catch (SQLException e) {
            // 예외 메시지 및 스택 트레이스 출력
            System.err.println("Error occurred while fetching diaries by user ID:");
            e.printStackTrace();
            throw e; // 예외를 다시 던져 호출 계층에서 처리되도록 설정
        }
        return diaries;
    }


}