package com.example.demo.dao;

import java.util.List;
import com.example.demo.dto.BooksDTO;


public interface DbMapper {
	public List<BooksDTO> getList( ) throws Exception;
}
