# Springboot Actuator
애플리케이션에 대한 모니터링 하고 매트릭 정보를 수집하고 이 정보들을 HTTP 또는 JMX를 통하여서 관리


## Springboot Actuator  
### micrometer
- application 지표를 제공하는 라이브러리  
- application 의 지표 수집 활동에 오버헤드가 거의 또는 전혀 없도록 설계됨

#### micrometer 지표
- Gabage Collection 과 관련된 통계
- CPU 사용량
- 메모리 사용량
- Thread 사용량
- Data Source 사용량
- 스프링 MVC 요청 지연 시간
- Kafka 커넥션 팩토리
- 캐싱
- 로그백에 기록된 이벤트 수
- 가동 시간

### Acturator 와 micrometer 구성
#### pom.xml
```
    <!-- actuator -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-actuator</artifactId>
	  </dependency>

    <!-- micrometer -->
		<dependency>
			<groupId>io.micrometer</groupId>
			<artifactId>micrometer-registry-prometheus</artifactId>
	  </dependency>
		<dependency>
			<groupId>io.micrometer</groupId>
			<artifactId>micrometer-core</artifactId>
	  </dependency>
```

#### application.properties
```
# -----------------------------------------------------------------------------
# actuator
# -----------------------------------------------------------------------------
# 주요 웹 엔드포인트 구성
management.server.port=
management.server.servlet.context-path=

management.endpoints.jmx.exposure.include=health,info,httptrace
# management.endpoint.web.exposure.exclude=
management.endpoint.web.base-path=/actuator
# management.endpoint.web.path-mapping=

# 모든 Actuator 웹 엔드포인트 노출 구성
# health 상세 조회 옵션 : *never|when-authorized|always
management.endpoint.health.show-details=always
management.endpoints.web.exposure.include=*
management.endpoints.web.exposure.exclude=env,beans

# 모든 엔드포인트들을 전체 활성화시키거나 비활성화. 비어 있으면 각 엔드포인트 활성화 설정에 위임
management.endpoints.enabled-by-default=true

management.endpoint.beans.enabled=true
management.endpoint.conditions.enabled=true
management.endpoint.configprops.enabled=true
management.endpoint.env.enabled=true
management.endpoint.health.enabled=true
management.endpoint.logfile.enabled=true
management.endpoint.loggers.enabled=true
management.endpoint.mappings.enabled=true
management.endpoint.prometheus.enabled=true
# shutdown 엔드포인트는 기본이 비활성화
management.endpoint.shutdown.enabled=false

# /actuator 페이지를 통해 노출할 endpoint(prometheus) 설정
management.endpoint.web.exposure.include=prometheus

info.project.version=@project.version@
info.java.version=@java.version@
info.spring.framework.version=@spring-framework.version@
info.spring.data.version=@spring-data-bom.version@
```

## Prometheus  
- [prometheus.yml](./prometheus.yml)
```
# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    # prometheus ipaddr:portno
    - targets: ['localhost:9090']
    
  - job_name: 'spring-actuator'
    metrics_path: '/actuator/prometheus'
    scrape_interval: 5s
    static_configs:
    - targets: ['localhost:7070']
```

## Grafana
- 시계열 데이터를 표시하는 오픈 소스  

> [SpringBoot APM Dashboard](https://grafana.com/grafana/dashboards/12900-springboot-apm-dashboard/)  