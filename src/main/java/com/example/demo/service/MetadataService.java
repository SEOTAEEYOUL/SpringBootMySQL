package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.MetadataDTO;

import java.io.IOException;

import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

@Service
public class MetadataService {
    public String fetchMetadata(String metadataPath) {
        String url = "http://10.70.16.10/latest/meta-data/" + metadataPath;
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpGet request = new HttpGet(url);
            return EntityUtils.toString(client.execute(request).getEntity());
        }
        catch (IOException e) {
            return "Error fetching metadata: " + e.getMessage();
        }
    }
}
