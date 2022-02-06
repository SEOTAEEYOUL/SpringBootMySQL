package com.example.demo.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BooksDTO {
	private int seqNo;
	private String title;
	private String author;
	private Date published_date;
	private double price;
	
	public BooksDTO() {		
	}
	
	public BooksDTO(int SeqNo,
	  String Title,
		String Author,
		double Price) {
		super( );
		this.seqNo = SeqNo;
		this.title = Title;
		this.author = Author;
		this.published_date = new Date( );
		this.price = Price;
	}

	public BooksDTO(int SeqNo, String Title, String Author, String publishedDate, double Price) throws Exception {
		super( );
		this.seqNo = SeqNo;
		this.title = Title;
		this.author = Author;
		this.price = Price;
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd"); // "yyyy-MM-dd HH:mm:ss"
		this.published_date = transFormat.parse(publishedDate);
	}

	public int getSeqNo( ) {
		return (this.seqNo);
	}
	
	public String getTitle( ) {
		return (this.title);
	}
	
	public String getAuthor( ) {
		return (this.author);	
	}

	public String getPublished_Date( ) {		
		// Date date = new Date( );
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = format.format(this.published_date);
		return (dateString);	
	}

	public double getPrice( ) {
		return (this.price);	
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "seqNo=" + getSeqNo( ) + 
		       ", title="+ getTitle( ) +
					 ", author="+ getAuthor( ) +
					 ", published_date=" + getPublished_Date( ) +
					 ", price=" + getPrice( );
	}
}
