-- 카테고리 데이터 삽입
INSERT INTO categories (name) VALUES 
('관리체계'),
('정보 유체 관리'),
('침해 방지'),
('종합 관리');

-- 정성 문항 테이블 데이터 삽입
INSERT INTO qualitative_questions (
    question_number, indicator, indicator_definition, evaluation_criteria, reference_info,
    score_consult, score_not_applicable
)
VALUES
    (1, '개인정보 보호 정책이 적절한가?', '개인정보 보호 정책이 기관 내에서 효과적으로 적용되는지 여부', '보호 정책 준수 여부', '개인정보 보호법 제29조', 2, 0),
    (2, '개인정보 보호 교육이 효과적인가?', '기관에서 시행하는 개인정보 보호 교육의 효과성', '교육 참여율 및 만족도', '개인정보 보호법 제30조', 2, 0),
    (3, '개인정보 보호 책임자의 역할이 명확한가?', '기관 내 보호책임자의 역할과 책임이 명확한지', '책임자의 업무 수행 여부', '개인정보 보호법 제31조', 2, 0),
    (4, '개인정보 보관 및 삭제 기준이 명확한가?', '보관 및 삭제 절차가 체계적으로 운영되는지 여부', '보관 및 삭제 정책 준수 여부', '개인정보 보호법 제32조', 2, 0),
    (5, '외부 위탁업체의 개인정보 보호가 적절한가?', '개인정보 처리 업무 위탁 시 보호 조치의 적절성', '위탁업체의 보호 대책', '개인정보 보호법 제33조', 1, 0),
    (6, '개인정보 보호를 위한 내부 감사가 이루어지는가?', '정기적으로 내부 감사를 수행하는지 여부', '내부 감사 수행 빈도 및 보고서', '개인정보 보호법 제34조', 1, 0),
    (7, '개인정보 보호 사고 발생 시 대응이 적절한가?', '유출 사고 발생 시 신속한 대응 및 후속 조치 여부', '사고 대응 절차 및 개선 조치', '개인정보 보호법 제35조', 1, 0),
    (8, '개인정보 보호 관련 법령 개정 사항을 반영하고 있는가?', '최신 법령 개정 사항을 보호 대책에 반영하는지 여부', '법률 개정 반영 여부', '개인정보 보호법 제36조', 1, 0);

-- 정량 문항 테이블 데이터 삽입
INSERT INTO quantitative_questions (
    question_number, question, evaluation_criteria, legal_basis,
    score_fulfilled, score_unfulfilled, score_consult, score_not_applicable, category_id
)
VALUES
(1, '개인정보 보호 정책이 수립되어 있는가?', '정책 문서화 여부', '개인정보 보호법 제29조', 3.2, 0, 1, 0, 1),
(2, '개인정보 보호 교육이 정기적으로 이루어지는가?', '교육 시행 여부', '개인정보 보호법 제30조', 3.2, 0, 1, 0, 1),
(3, '개인정보 보호책임자가 지정되어 있는가?', '책임자 지정 여부', '개인정보 보호법 제31조', 3.2, 0, 1, 0, 1),
(4, '개인정보 보호 대책이 명확하게 정의되어 있는가?', '보호 대책 명확성', '개인정보 보호법 제32조', 3.2, 0, 1, 0, 1),
(5, '비밀번호 정책이 시행되고 있는가?', '비밀번호 설정 및 변경 정책', '개인정보 보호법 제33조', 3.2, 0, 1, 0, 1),
(6, '개인정보 암호화가 적절히 수행되는가?', '암호화 적용 여부', '개인정보 보호법 제34조', 3.2, 0, 1, 0, 1),
(7, '개인정보 접근 통제 정책이 마련되어 있는가?', '접근 통제 여부', '개인정보 보호법 제35조', 3.2, 0, 1, 0, 1),
(8, '개인정보 보관 및 파기 정책이 수립되어 있는가?', '보관 기간 및 파기 기준', '개인정보 보호법 제36조', 3.2, 0, 1, 0, 1),
(9, '개인정보 이용 동의 절차가 적절히 운영되고 있는가?', '이용 동의 절차 여부', '개인정보 보호법 제37조', 3.2, 0, 1, 0, 1),
(10, '개인정보 처리방침이 공시되어 있는가?', '처리방침 공개 여부', '개인정보 보호법 제38조', 3.2, 0, 1, 0, 1),
(11, '개인정보 보호 관련 내부 점검이 정기적으로 이루어지는가?', '내부 점검 주기 및 결과 관리', '개인정보 보호법 제39조', 1.3, 0, 0.5, 0, 2),
(12, '개인정보 보호 대책이 최신 법령을 반영하고 있는가?', '법령 반영 여부', '개인정보 보호법 제40조', 1.3, 0, 0.5, 0, 2),
(13, '개인정보 보호를 위한 모니터링 시스템이 운영되고 있는가?', '모니터링 시스템 구축 여부', '개인정보 보호법 제41조', 1.3, 0, 0.5, 0, 2),
(14, '개인정보 보호를 위한 보안 장비가 도입되어 있는가?', '보안 장비 도입 여부', '개인정보 보호법 제42조', 1.3, 0, 0.5, 0, 2),
(15, '개인정보 처리 시스템에 대한 보안 점검이 이루어지는가?', '시스템 보안 점검 여부', '개인정보 보호법 제43조', 1.3, 0, 0.5, 0, 2),
(16, '개인정보 보호를 위한 위협 대응 체계가 마련되어 있는가?', '위협 대응 절차 여부', '개인정보 보호법 제44조', 0.47, 0, 0.2, 0, 3),
(17, '개인정보 보호를 위한 내부 감사를 수행하는가?', '내부 감사 실시 여부', '개인정보 보호법 제45조', 0.47, 0, 0.2, 0, 3),
(18, '개인정보 유출 사고 대응 계획이 마련되어 있는가?', '유출 사고 대응 여부', '개인정보 보호법 제46조', 0.47, 0, 0.2, 0, 3),
(19, '개인정보 보호책임자 교육이 정기적으로 이루어지는가?', '책임자 교육 여부', '개인정보 보호법 제47조', 0.47, 0, 0.2, 0, 3),
(20, '개인정보 처리자가 보안 서약을 하고 있는가?', '보안 서약 실시 여부', '개인정보 보호법 제48조', 0.47, 0, 0.2, 0, 3),
(21, '개인정보 처리 업무가 외부 위탁될 경우 계약이 적절히 이루어지는가?', '위탁 계약 체결 여부', '개인정보 보호법 제49조', 0.47, 0, 0.2, 0, 3),
(22, '외부 위탁 업체의 개인정보 보호 수준을 정기적으로 점검하는가?', '위탁 업체 점검 여부', '개인정보 보호법 제50조', 0.47, 0, 0.2, 0, 3),
(23, '개인정보 보호 대책이 국제 표준을 준수하고 있는가?', '국제 표준 준수 여부', '개인정보 보호법 제51조', 0.47, 0, 0.2, 0, 3),
(24, '개인정보 보호 조치가 비용 대비 효과적인가?', '비용 대비 효과 분석 여부', '개인정보 보호법 제52조', 0.47, 0, 0.2, 0, 3),
(25, '개인정보 보호 관련 법률 개정 사항을 반영하고 있는가?', '법률 개정 반영 여부', '개인정보 보호법 제53조', 0.47, 0, 0.2, 0, 3),
(26, '개인정보 보호 교육이 모든 직원에게 제공되고 있는가?', '교육 제공 여부', '개인정보 보호법 제54조', 2, 0, 1, 0, 3),
(27, '개인정보 보호 정책이 지속적으로 개선되고 있는가?', '지속적인 개선 여부', '개인정보 보호법 제55조', 2, 0, 1, 0, 3),
(28, '개인정보 보호 대책이 기술 발전을 반영하고 있는가?', '최신 기술 반영 여부', '개인정보 보호법 제56조', 2, 0, 1, 0, 3),
(29, '개인정보 보호 사고 사례가 공유되고 있는가?', '사고 사례 공유 여부', '개인정보 보호법 제57조', 2, 0, 1, 0, 3),
(30, '개인정보 보호 조치가 내부 규정에 따라 점검되고 있는가?', '내부 규정 준수 여부', '개인정보 보호법 제58조', 2, 0, 1, 0, 3),
(31, '개인정보 보호 계획이 적절히 이행되고 있는가?', '계획 이행 여부', '개인정보 보호법 제59조', 2, 0, 1, 0, 3),
(32, '개인정보 보호를 위한 보안 인증을 취득하였는가?', '보안 인증 여부', '개인정보 보호법 제60조', 2, 0, 1, 0, 3),
(33, '개인정보 보호 대책이 최신 법률 및 가이드라인을 따르고 있는가?', '법률 준수 여부', '개인정보 보호법 제61조', 2, 0, 1, 0, 3),
(34, '개인정보 보호 정책이 전체 직원에게 전달되고 있는가?', '정책 전달 여부', '개인정보 보호법 제62조', 2, 0, 1, 0, 3),
(35, '개인정보 보호를 위한 기술이 적절히 활용되고 있는가?', '보호 기술 활용 여부', '개인정보 보호법 제63조', 2, 0, 1, 0, 3),
(36, '개인정보 보호 대책이 기업 문화로 정착되고 있는가?', '기업 문화 정착 여부', '개인정보 보호법 제64조', 2, 0, 1, 0, 3),
(37, '개인정보 보호를 위한 보안 절차가 준수되고 있는가?', '보안 절차 준수 여부', '개인정보 보호법 제65조', 2, 0, 1, 0, 3),
(38, '개인정보 보호 계획이 경영진의 승인 하에 이루어지는가?', '경영진 승인 여부', '개인정보 보호법 제66조', 2, 0, 1, 0, 3),
(39, '개인정보 보호 조치가 데이터 보호 요구 사항을 충족하는가?', '데이터 보호 충족 여부', '개인정보 보호법 제67조', 2, 0, 1, 0, 3),
(40, '개인정보 보호 교육이 외부 전문가에 의해 제공되는가?', '외부 전문가 교육 여부', '개인정보 보호법 제68조', 2, 0, 1, 0, 3),
(41, '개인정보 보호 점검 결과가 보고되고 있는가?', '점검 보고 여부', '개인정보 보호법 제69조', 1, 0, 1, 0, 3),
(42, '개인정보 보호 위반 시 제재 조치가 마련되어 있는가?', '제재 조치 마련 여부', '개인정보 보호법 제70조', 1, 0, 1, 0, 3),
(43, '개인정보 보호 조치가 산업별 규제를 따르고 있는가?', '산업 규제 준수 여부', '개인정보 보호법 제71조', 1, 0, 1, 0, 3);

-- 슈퍼유저 만들기
INSERT INTO SuperUser (name, email, password, phone_number) 
VALUES ('여상수', 'martin@martinlab.co.kr', '$2b$10$sUrHUz4wHleF0/y/sMYIXeMjYRQdvRVjp0QWCRlmKA5APG9bC5NfS','010-2743-0001');

-- 슈퍼유저 멤버 타입 업데이트
UPDATE SuperUser
SET member_type = 'superuser';

-- 정량 문항 카테고리 업데이트
UPDATE quantitative_questions 
SET category_id = (SELECT id FROM categories WHERE name = '관리체계')
WHERE question_number IN (1, 2, 3, 4, 5, 6, 7, 8);

UPDATE quantitative_questions 
SET category_id = (SELECT id FROM categories WHERE name = '정보 유체 관리')
WHERE question_number IN (9, 10, 11, 12, 13, 14, 15, 16);

UPDATE quantitative_questions 
SET category_id = (SELECT id FROM categories WHERE name = '침해 방지')
WHERE question_number IN (17, 18, 19, 20, 21, 22, 23, 24);

UPDATE quantitative_questions 
SET category_id = (SELECT id FROM categories WHERE name = '종합 관리')
WHERE question_number IN (25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43);

-- 정량 응답 테이블 파일 경로 기본값 수정
ALTER TABLE quantitative_responses 
MODIFY COLUMN file_path VARCHAR(255) DEFAULT '';

-- 정성 응답 테이블 파일 경로 기본값 수정
ALTER TABLE qualitative_responses 
MODIFY COLUMN file_path VARCHAR(255) DEFAULT '';