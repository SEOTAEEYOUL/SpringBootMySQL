package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dto.MetadataDTO;
import com.example.demo.service.MetadataService;

@RestController
public class MetadataController {
    @Autowired
    private MetadataService metadataService;

    @GetMapping("/metadata.do")
    public ModelAndView getMetadata(Model model, HttpServletRequest request) throws Exception {
        // model.addAttribute("ipAddress", request.getRemoteAddr());
        // String ipaddr = model.addAttribute("ipAddress", request.getRemoteAddr());
        String ipaddr = request.getRemoteAddr();
        String instanceId = metadataService.fetchMetadata("instance-id");
        String zone = metadataService.fetchMetadata("placement/availability-zone");
        // return new Metadata(instanceId, zone);

        MetadataDTO metadata = new MetadataDTO(ipaddr, instanceId, zone);

        return (new ModelAndView("Metadata", "metadata", metadata));
    }
}