package com.example.demo.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class JdbcDTO {
    private String dbUsername;
    private String dbPassword;
    private String jdbcDriver;
    private String jdbcConnection;

	
    public JdbcDTO( ) {
    }

    public JdbcDTO(String dbUsername,
        String dbPassword,
        String jdbcDriver,
        String jdbcConnection) {
        super( );
        this.dbUsername     = dbUsername;
        this.dbPassword     = dbPassword;
        this.jdbcDriver     = jdbcDriver;
        this.jdbcConnection = jdbcConnection;
    }

    public String getDbUsername( ) {
        return (this.dbUsername);
    }

    public String getDbPassword( ) {
        return (this.dbPassword);	
    }

    public String getJdbcDriver( ) {
        return (this.jdbcDriver);	
    }

    public String getJdbcConnection( ) {
        return (this.jdbcConnection);
    }


    @Override
    public String toString() {
        // TODO Auto-generated method stub
        return "dbUsername=" + getDbUsername( ) + 
            ", dbPassword="+ getDbPassword( ) +
            ", jdbcDriver="+ getJdbcDriver( ) +
            ", jdbcConnection=" + getJdbcConnection( );
    }
}
