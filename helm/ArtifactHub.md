# Artifact Hub
- Artifact Hub 는 Helm 차트를 포함한 쿠버네티스 패키지를 검색하고 공유할 수 있는 플랫폼 입니다
- Artifact Hub 를 활용하면 더 넓은 커뮤니티와 차트를 공유하고 협업 할 수 있음

## Artifact Hub 에 Chart 등록하기
1. Artifact Hub 계정 생성
2. 새 저장소 추가 (예: Github 저장소 URL)
3. `metadata.yaml` 파일 작성
    ```
    # mychart/metadata.yaml
    version: 1.0.0
    name: myhart
    displayName: My Helm Chart
    descritpion: A Helm chart of Kubernetes
    type: helm
    ```

4. artifact Hub 에서 차트 검색 및 사용
    - Artifact Hub 웹사이트에서 차트 검색
    - 설치 명령어 확인 및 실행
    ```
    helm repo add myrepo https://username.github.io/helm-charts
    helm install myrelease myrepo/mychart    
    ```
