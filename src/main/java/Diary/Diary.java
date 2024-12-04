package Diary;

public class Diary {
	private int recordId;
	private int aid;
	private String title;
	private String date;
	private String emotion;
	private String content;
	private double emotionScore;
	
	
	

	public double getEmotionScore() {
		return emotionScore;
	}

	public void setEmotionScore(double emotionScore) {
		this.emotionScore = emotionScore;
	}

	public int getRecordId() {
		return recordId;
	}

	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getEmotion() {
		return emotion;
	}

	public void setEmotion(String emotion) {
		this.emotion = emotion;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}