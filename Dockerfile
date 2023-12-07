# 사용할 기본 이미지 지정
FROM openjdk:17-jdk

# 컨테이너 내에서 애플리케이션 파일을 위치시킬 디렉토리 생성
WORKDIR /app

# 호스트 머신의 빌드 결과물(.jar 파일 등)을 컨테이너 내부로 복사
# GitHub Actions 러너의 현재 디렉토리(체크아웃된 리포지토리의 루트)에서 빌드 디렉토리로 복사합니다.
COPY build/libs/dev-0.0.1-SNAPSHOT.jar app.jar

# 컨테이너가 시작될 때 실행될 명령어
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

# 애플리케이션 포트를 외부에 노출
EXPOSE 9090
