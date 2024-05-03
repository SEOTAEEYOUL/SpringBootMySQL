package com.example.demo.dto;

public class MetadataDTO {
    private String ipaddr;
    private String instanceId;
    private String zone;

    public MetadataDTO(String ipaddr, String instanceId, String zone) {
        this.ipaddr     = ipaddr;
        this.instanceId = instanceId;
        this.zone = zone;
    }

    // Getters and setters
    public String getIpaddr() {
        return ipaddr;
    }

    public void setIpaddr( ) {
        this.ipaddr= ipaddr;
    }

    public String getInstanceId() {
        return instanceId;
    }

    public void setInstanceId(String instanceId) {
        this.instanceId = instanceId;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }
}
