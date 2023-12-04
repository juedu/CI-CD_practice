# 프로젝트 개요

## 서버 어플리케이션

### 사용 언어 및 프레임워크
- **언어**: Java
- **프레임워크**: Spring Boot
- **개발 환경**: Windows, Visual Studio Code

## STEP 01: 웹 서버 생성

1. **프로젝트 생성 및 초기 설정**:
   - **Spring Boot 프로젝트 생성**: Spring Initializr([start.spring.io](https://start.spring.io/))를 사용하여 기본 설정을 완료합니다. 필요한 의존성으로는 'Spring Web', 'Spring Boot Actuator'를 선택합니다.
   - **프로젝트 Import**: 생성된 프로젝트를 vscode 로 가져오고 GRADLE 등 확장프로그램을 설치합니다..

2. **Health-Check Router 구현**:
   - **Spring Boot Actuator 추가**: `pom.xml` 또는 `build.gradle`에 Spring Boot Actuator 의존성을 추가합니다.
   - **Health Endpoint 활성화**: `application.properties` 또는 `application.yml`에 Actuator의 health endpoint를 활성화하는 설정을 추가합니다.

3. **개발(dev) 및 운영(prod) 환경 설정**:
   - **프로파일 설정**: `application-dev.properties`와 `application-prod.properties` 파일을 생성하여 각 환경에 맞는 설정을 정의합니다.
   - **환경 변수 설정**: AWS EC2 인스턴스에서 환경 변수를 설정하여, 해당 환경에 맞는 프로파일을 활성화합니다. 예를 들어, `SPRING_PROFILES_ACTIVE=prod` 설정을 통해 운영 환경을 활성화할 수 있습니다.

### 환경 설정
- **Dev (개발)**: 로컬 윈도우 환경에서 개발 및 테스트를 진행합니다. IDE를 통해 애플리케이션을 실행하고, `application-dev.properties`에 정의된 설정을 사용합니다.
- **Staging (스테이징)**: 프로덕션과 유사한 환경에서 추가적인 테스트 및 검증을 위해 `stg` 브랜치와 연동된 자동화된 파이프라인을 통해 배포합니다.
- **Prod (프로덕션)**: 실제 사용자가 사용하는 환경으로, `prod` 브랜치에서 최종적으로 배포되며, `application-prod.properties`에 정의된 설정을 사용합니다.

---


# 전략

## STEP 01: 웹 서버 생성
- Spring Boot 프로젝트 생성 및 기본 설정
- Health-Check Endpoint (`/actuator/health`) 구현
- 환경 설정 (`application.properties` 또는 `application.yml`): `dev`, `prod`

## STEP 02: 빌드 환경 구축
- Docker를 사용한 컨테이너화 및 이미지 빌드
- Dockerfile 작성 및 로컬 환경에서 테스트
- GitHub Actions를 활용한 CI/CD 파이프라인 구축
  - 코드 Push, PR 시 자동 빌드 및 테스트
  - Lint, Test Coverage 등의 추가적인 검증 단계 포함
  - 환경(`dev`, `stg`, `prod`)별 파이프라인 구성

## STEP 03: 배포 환경 구축
- AWS ECR 및 ECS Fargate 사용
- Docker 이미지 ECR에 업로드
- ECS Fargate를 통한 서비스 배포 및 관리
- 보안 및 리소스 관리를 위한 IAM 사용자 설정
- GitHub Actions의 Secret을 활용한 보안 정보 관리

---

# 추가 정보
- 프로젝트 관련 문서, 설정 파일, 코드 등은 본 GitHub 저장소에서 관리됩니다.
- 로컬 환경에 너무 많은 다른 서버들이 세팅되어있어서 본 프로젝트의 기본 포트는 9090으로 진행합니다.

---
