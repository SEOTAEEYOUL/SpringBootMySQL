package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import org.springframework.beans.factory.annotation.Value;

import com.example.demo.dto.JdbcDTO;

@Service
public class JdbcService {
    // 환경 변수 값을 필드에 주입
    @Value("${DB_USERNAME}")
    private String dbUsername;

    @Value("${DB_PASSWORD}")
    private String dbPassword;

    @Value("${DB_DRIVER}")
    private String jdbcDriver;

    @Value("${DB_CONNECTION}")
    private String jdbcConnection;

    // dbUsername     = System.getenv("DB_USERNAME");
    // dbPassword     = System.getenv("DB_PASSWORD");
    // jdbcDriver     = System.getenv("DB_DRIVER");
    // jdbcConnection = System.getenv("DB_CONNECTION");

    public JdbcDTO getJdbcDetail( ) throws Exception {
        JdbcDTO jdbcDto = new JdbcDTO(dbUsername,
                    dbPassword,
                    jdbcDriver,
                    jdbcConnection);

        return (jdbcDto);
	}
}

