-- 데이터베이스 설정
DROP DATABASE IF EXISTS compliance;
CREATE DATABASE compliance CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE compliance;

-- 회원 테이블
CREATE TABLE `User` (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    institution_name VARCHAR(255) NOT NULL COMMENT '기관명',
    institution_address VARCHAR(255) NOT NULL COMMENT '기관 주소',
    representative_name VARCHAR(255) NOT NULL COMMENT '대표자 이름',
    email VARCHAR(255) NOT NULL UNIQUE COMMENT '이메일',
    password VARCHAR(255) NOT NULL COMMENT '비밀번호',
    phone_number VARCHAR(15) NOT NULL COMMENT '전화번호',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '가입 날짜',
    member_type VARCHAR(20) NOT NULL DEFAULT '기관회원' COMMENT '회원 유형',
    email_verified BOOLEAN NOT NULL DEFAULT FALSE COMMENT '이메일 인증 여부',
    email_token VARCHAR(255) DEFAULT NULL COMMENT '이메일 인증 토큰',
    email_token_expiration DATETIME DEFAULT NULL COMMENT '이메일 토큰 만료 시간'
);

-- INDEX 추가
ALTER TABLE `User`
ADD INDEX idx_email (email),
ADD INDEX idx_phone_number (phone_number);

-- 전문가 회원 테이블
CREATE TABLE expert (
    id INT NOT NULL AUTO_INCREMENT COMMENT '전문가 ID',
    name VARCHAR(255) NOT NULL COMMENT '전문가 이름',
    institution_name VARCHAR(255) NOT NULL COMMENT '소속 기관명',
    ofcps VARCHAR(255) NOT NULL COMMENT '전문가 직책',
    phone_number VARCHAR(20) NOT NULL COMMENT '전화번호',
    email VARCHAR(255) NOT NULL COMMENT '이메일',
    major_carrea TEXT NOT NULL COMMENT '전문 경력',
    password VARCHAR(255) NOT NULL COMMENT '비밀번호',
    PRIMARY KEY (id),
    UNIQUE KEY uk_email (email)
);

-- 비밀번호 재설정 요청을 저장할 테이블을 추가 
CREATE TABLE PasswordResetTokens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    expires_at DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- 슈퍼유저 테이블
CREATE TABLE SuperUser (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '슈퍼유저 ID',
    name VARCHAR(255) NOT NULL COMMENT '이름',
    email VARCHAR(255) NOT NULL UNIQUE COMMENT '이메일',
    password VARCHAR(255) NOT NULL COMMENT '비밀번호',
    phone_number VARCHAR(255) NOT NULL COMMENT '전화번호',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '가입 날짜',
    member_type VARCHAR(50) NOT NULL DEFAULT 'superuser' COMMENT '회원 유형'
);

-- 카테고리 테이블
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '카테고리 ID',
    name VARCHAR(255) NOT NULL UNIQUE COMMENT '카테고리명'
);

-- 시스템 테이블
CREATE TABLE systems (
    id INT AUTO_INCREMENT PRIMARY KEY, -- 시스템 ID
    user_id INT NOT NULL COMMENT '회원 ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '등록 날짜',
    name VARCHAR(255) NOT NULL COMMENT '시스템 이름',
    num_data_subjects INT NOT NULL COMMENT '정보 주체 수',
    purpose VARCHAR(255) NOT NULL COMMENT '처리 목적',
    is_private BOOLEAN NOT NULL COMMENT '민감 정보 포함 여부',
    is_unique BOOLEAN NOT NULL COMMENT '고유 식별 정보 포함 여부',
    is_resident BOOLEAN NOT NULL COMMENT '주민등록번호 포함 여부',
    reason ENUM('동의', '법적 근거', '기타') NOT NULL COMMENT '수집 근거',
    assessment_status ENUM('시작전', '완료') NOT NULL COMMENT '평가 상태',
    assignment_id INT DEFAULT NULL COMMENT '담당 ID',

    -- 인덱스 추가
    INDEX idx_user_id (user_id),
    INDEX idx_assignment_id (assignment_id),

    -- 외래키 제약 조건 추가 (assignment 제외)
    CONSTRAINT fk_systems_user FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- 자가진단 입력 테이블
CREATE TABLE self_assessment (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '입력 ID',
    user_id INT NOT NULL COMMENT '회원 ID',
    systems_id INT NOT NULL COMMENT '시스템 ID',
    user_scale VARCHAR(255) NOT NULL COMMENT '사용자 규모',
    organization ENUM('교육기관', '공공기관', '국가기관') NOT NULL COMMENT '공공기관 분류',
    personal_info_system ENUM('있음', '없음') NOT NULL COMMENT '개인정보처리 시스템 여부',
    member_info_homepage ENUM('있음', '없음') NOT NULL COMMENT '회원정보 홈페이지 여부',
    external_data_provision ENUM('있음', '없음') NOT NULL COMMENT '외부정보 제공 여부',
    cctv_operation ENUM('운영', '미운영') NOT NULL COMMENT 'CCTV 운영 여부',
    task_outsourcing ENUM('있음', '없음') NOT NULL COMMENT '업무 위탁 여부',
    personal_info_disposal ENUM('있음', '없음') NOT NULL COMMENT '개인정보 폐기 여부',
    submitted_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '제출 시간',
    homepage_privacy VARCHAR(255) DEFAULT '없음' COMMENT '홈페이지 개인정보 처리 여부',

    -- 인덱스 추가
    INDEX idx_user_id (user_id),
    INDEX idx_systems_id (systems_id),

    -- 외래키 제약 조건 추가
    FOREIGN KEY (systems_id) REFERENCES systems(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- assignment 테이블 생성
CREATE TABLE assignment (
    id INT NOT NULL AUTO_INCREMENT COMMENT '담당 ID',
    expert_id INT NOT NULL COMMENT '전문가 ID',
    systems_id INT NOT NULL COMMENT '시스템 ID',
    assigned_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '할당 날짜',
    feedback_status VARCHAR(20) NOT NULL DEFAULT '대기중' COMMENT '피드백 상태',
    PRIMARY KEY (id),
    
    -- UNIQUE KEY 추가
    UNIQUE KEY unique_assignment (expert_id, systems_id),
    
    -- 인덱스 추가
    INDEX idx_system_id (systems_id),
    INDEX idx_expert_id (expert_id),
    
    -- 외래키 제약 조건 추가
    CONSTRAINT fk_assignment_systems FOREIGN KEY (systems_id) REFERENCES systems(id) ON DELETE CASCADE,
    CONSTRAINT fk_assignment_expert FOREIGN KEY (expert_id) REFERENCES expert(id) ON DELETE CASCADE 
);

-- 시스템 테이블의 assignment_id 외래키 추가
ALTER TABLE systems 
ADD CONSTRAINT fk_systems_assignment FOREIGN KEY (assignment_id) REFERENCES assignment(id) ON DELETE SET NULL;

-- 정량 문항 테이블
CREATE TABLE quantitative_questions (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '문항 ID',
    question_number INT NOT NULL COMMENT '문항 번호',
    question TEXT NOT NULL COMMENT '문항 내용',
    evaluation_criteria LONGTEXT COMMENT '평가기준',
    legal_basis TEXT COMMENT '근거 법령',
    score_fulfilled DECIMAL(5,2) NOT NULL DEFAULT 5 COMMENT '이행 점수',
    score_unfulfilled DECIMAL(5,2) NOT NULL DEFAULT 0 COMMENT '미이행 점수',
    score_consult DECIMAL(5,2) NOT NULL DEFAULT 2 COMMENT '자문필요 점수',
    score_not_applicable DECIMAL(5,2) NOT NULL DEFAULT 0 COMMENT '해당없음 점수',
    category_id INT NOT NULL COMMENT '카테고리 ID',

    -- UNIQUE KEY 정의
    UNIQUE KEY uk_question_number (question_number),

    -- FOREIGN KEY 정의
    CONSTRAINT fk_quantitative_questions_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- 정량 응답 테이블
CREATE TABLE quantitative_responses (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '응답 ID',
    systems_id INT NOT NULL COMMENT '시스템 ID',
    user_id INT NOT NULL COMMENT '회원 ID',
    question_id INT NOT NULL COMMENT '문항 ID',
    diagnosis_round INT NOT NULL DEFAULT 1 COMMENT '진단 회차',
    response ENUM('이행', '미이행', '해당없음', '자문필요') DEFAULT NULL COMMENT '응답',
    additional_comment TEXT COMMENT '추가 의견',
    file_path VARCHAR(255) DEFAULT NULL COMMENT '파일 업로드 경로',
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 수정 시간',
    
    -- UNIQUE 제약 조건 추가
    CONSTRAINT uk_system_user_question_round UNIQUE (systems_id, user_id, question_id, diagnosis_round),
    
    -- 인덱스 추가
    INDEX idx_user_id (user_id),
    INDEX idx_question_id (question_id),
    INDEX idx_systems_id (systems_id),
    
    -- FOREIGN KEY 설정
    CONSTRAINT fk_quantitative_responses_system FOREIGN KEY (systems_id) REFERENCES systems(id) ON DELETE CASCADE,
    CONSTRAINT fk_quantitative_responses_user FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    CONSTRAINT fk_quantitative_responses_question FOREIGN KEY (question_id) REFERENCES quantitative_questions(id) ON DELETE CASCADE
);

-- 정성 문항 테이블
CREATE TABLE qualitative_questions (
    id INT NOT NULL AUTO_INCREMENT COMMENT '문항 ID',
    question_number INT NOT NULL COMMENT '문항 번호',
    indicator TEXT NOT NULL COMMENT '지표',
    indicator_definition TEXT COMMENT '지표 정의',
    evaluation_criteria LONGTEXT COMMENT '평가기준',
    reference_info TEXT COMMENT '참고사항',
    score_consult DECIMAL(5,2) NOT NULL DEFAULT 1 COMMENT '자문필요 점수',
    score_not_applicable DECIMAL(5,2) NOT NULL DEFAULT 0 COMMENT '해당없음 점수',
    
    PRIMARY KEY (id),
    
    -- UNIQUE KEY 추가
    UNIQUE KEY uk_question_number (question_number)
);

-- 정성 응답 테이블
CREATE TABLE qualitative_responses (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '응답 ID',
    systems_id INT NOT NULL COMMENT '시스템 ID',
    user_id INT NOT NULL COMMENT '회원 ID',
    question_id INT NOT NULL COMMENT '문항 ID',
    diagnosis_round INT NOT NULL DEFAULT 1 COMMENT '진단 회차',
    response ENUM('자문필요', '해당없음') DEFAULT NULL COMMENT '응답 상태',
    additional_comment TEXT COMMENT '추가 의견',
    file_path VARCHAR(255) DEFAULT NULL COMMENT '파일 업로드 경로',
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 수정 시간',

    -- UNIQUE 제약 조건 추가
    CONSTRAINT uk_system_user_question_round UNIQUE (systems_id, user_id, question_id, diagnosis_round),
    
    -- 인덱스 추가
    INDEX idx_user_id (user_id),
    INDEX idx_question_id (question_id),
    INDEX idx_systems_id (systems_id),
    
    -- 외래키 제약 조건 추가
    CONSTRAINT fk_qualitative_responses_system FOREIGN KEY (systems_id) REFERENCES systems(id) ON DELETE CASCADE,
    CONSTRAINT fk_qualitative_responses_user FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    CONSTRAINT fk_qualitative_responses_question FOREIGN KEY (question_id) REFERENCES qualitative_questions(id) ON DELETE CASCADE
);

-- 자가진단 결과 테이블
CREATE TABLE assessment_result (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '결과 ID',
    systems_id INT NOT NULL COMMENT '시스템 ID',
    user_id INT NOT NULL COMMENT '회원 ID',
    assessment_id INT NOT NULL COMMENT '자가진단 입력 ID',
    score INT NOT NULL COMMENT '점수',
    feedback_status ENUM('전문가 자문이 반영되기전입니다', '전문가 자문이 반영되었습니다') NOT NULL COMMENT '피드백 상태',
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '완료 시간',
    grade ENUM('S', 'A', 'B', 'C', 'D') NOT NULL COMMENT '등급',
    diagnosis_round INT NOT NULL DEFAULT 1 COMMENT '진단 회차',


    -- UNIQUE KEY 추가
    CONSTRAINT uk_system_user_round UNIQUE (systems_id, user_id, diagnosis_round),

    -- 인덱스 추가
    INDEX idx_systems_id (systems_id),
    INDEX idx_user_id (user_id),
    INDEX idx_assessment_id (assessment_id),

    -- 외래키 제약 조건 추가
    CONSTRAINT fk_assessment_result_system FOREIGN KEY (systems_id) REFERENCES systems(id) ON DELETE CASCADE,
    CONSTRAINT fk_assessment_result_user FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    CONSTRAINT fk_assessment_result_assessment FOREIGN KEY (assessment_id) REFERENCES self_assessment(id) ON DELETE CASCADE
);

-- 새로운 `feedback` 테이블
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '피드백 ID',
    systems_id INT NOT NULL COMMENT '시스템 ID',
    user_id INT NOT NULL COMMENT '기관회원 ID',
    expert_id INT NOT NULL COMMENT '전문가 ID',
    quantitative_response_id INT NULL COMMENT '정량 응답 ID (quantitative_responses)',
    qualitative_response_id INT NULL COMMENT '정성 응답 ID (qualitative_responses)',
    feedback TEXT NOT NULL COMMENT '피드백 내용',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '피드백 생성 날짜',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '피드백 수정 날짜',

    -- 관계 설정 (정량/정성 응답 테이블을 각각 참조)
    FOREIGN KEY (systems_id) REFERENCES systems(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (expert_id) REFERENCES expert(id) ON DELETE CASCADE,
    FOREIGN KEY (quantitative_response_id) REFERENCES quantitative_responses(id) ON DELETE CASCADE,
    FOREIGN KEY (qualitative_response_id) REFERENCES qualitative_responses(id) ON DELETE CASCADE
);

-- 시스템 테이블의 file_path 컬럼 수정
ALTER TABLE quantitative_responses 
MODIFY COLUMN file_path VARCHAR(255) DEFAULT '';

ALTER TABLE qualitative_responses 
MODIFY COLUMN file_path VARCHAR(255) DEFAULT '';