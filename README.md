# CI/CD Practice

Spring Boot 애플리케이션을 GitHub Actions, Docker, AWS (ECR + ECS Fargate)로 자동 배포하는 CI/CD 파이프라인 학습 프로젝트입니다.

## 파이프라인 구조

```
 Push (stg/prod)
       │
       ▼
 GitHub Actions
  ┌────────────────────────┐
  │ 1. Checkout            │
  │ 2. JDK 17 Setup        │
  │ 3. Gradle Build        │
  │ 4. Docker Image Build   │
  │ 5. ECR Login & Push     │
  │ 6. ECS Force Deploy     │
  └────────────────────────┘
       │
       ├── stg branch → ECS Cluster (Staging)
       └── prod branch → ECS Cluster (Production)
```

## 기술 스택

| 구성 요소 | 기술 |
|-----------|------|
| 언어 | Java 17 |
| 프레임워크 | Spring Boot 3.2 |
| 빌드 | Gradle |
| 컨테이너 | Docker |
| CI/CD | GitHub Actions |
| 레지스트리 | AWS ECR |
| 배포 | AWS ECS Fargate |
| 헬스체크 | Spring Boot Actuator |

## 브랜치 전략

| 브랜치 | 환경 | 용도 |
|--------|------|------|
| `dev` | Development | 로컬 개발 및 테스트 |
| `stg` | Staging | 프로덕션 유사 환경에서 검증 |
| `prod` | Production | 실제 서비스 환경 |

`stg` 또는 `prod` 브랜치에 Push하면 GitHub Actions가 자동으로 빌드 → Docker 이미지 생성 → ECR 푸시 → ECS 배포를 수행합니다.

## 프로젝트 구조

```
CI-CD_practice/
├── .github/workflows/
│   └── ci-cd-pipeline.yml    # GitHub Actions 워크플로우
├── src/
│   └── main/java/com/step1/  # Spring Boot 애플리케이션
├── build.gradle               # Gradle 빌드 설정
├── Dockerfile                 # Docker 이미지 정의
├── compose.yml                # 로컬 Docker Compose
└── settings.gradle
```

## 로컬 실행

```bash
# Gradle 빌드
./gradlew build

# 실행 (포트 9090)
./gradlew bootRun

# 헬스체크
curl http://localhost:9090/actuator/health
```

## Docker 실행

```bash
# 빌드
./gradlew build
docker build -t cicd-practice .

# 실행
docker run -p 9090:9090 cicd-practice

# 또는 Docker Compose
docker compose up
```

## CI/CD 워크플로우 상세

### 트리거 조건
- `stg` 브랜치 push → Staging 환경 배포
- `prod` 브랜치 push → Production 환경 배포

### 파이프라인 단계

1. **코드 체크아웃** — `actions/checkout@v2`
2. **JDK 17 설정** — AdoptOpenJDK
3. **Gradle 빌드** — `./gradlew build`
4. **Docker 이미지 빌드** — 브랜치명을 태그로 사용
5. **ECR 로그인 및 푸시** — `aws-actions/amazon-ecr-login`
6. **ECS 서비스 업데이트** — `force-new-deployment`로 롤링 배포

### 필요한 GitHub Secrets

| Secret | 설명 |
|--------|------|
| `AWS_ACCOUNT_ID` | AWS 계정 ID |
| `AWS_ACCESS_KEY_ID` | IAM 액세스 키 |
| `AWS_SECRET_ACCESS_KEY` | IAM 시크릿 키 |
| `AWS_REGION` | AWS 리전 (예: `ap-northeast-2`) |

## 환경 설정

각 환경별 Spring 프로파일로 설정을 분리합니다:

- `application-dev.properties` — 로컬 개발
- `application-stg.properties` — 스테이징
- `application-prod.properties` — 프로덕션

ECS 환경에서는 `SPRING_PROFILES_ACTIVE` 환경변수로 프로파일을 활성화합니다.

## 학습 목표

- [x] Spring Boot 웹 서버 + Actuator 헬스체크
- [x] Dev / Staging / Production 환경 분리
- [x] Dockerfile 작성 및 컨테이너화
- [x] GitHub Actions CI/CD 파이프라인
- [x] AWS ECR 이미지 레지스트리
- [x] AWS ECS Fargate 서비스 배포
- [x] 브랜치별 자동 배포 (stg → Staging, prod → Production)
