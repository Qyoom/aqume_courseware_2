# Cloze Quiz schema
 
# --- !Ups

CREATE SEQUENCE quiz_seq;
CREATE TABLE quiz (
    id integer NOT NULL DEFAULT nextval('quiz_seq'),
    title varchar(60),
    retries integer,
    drag BOOLEAN,
    instructions TEXT,
    created TIMESTAMP NULL,
    modified TIMESTAMP NULL,
    record_link TEXT,
    PRIMARY KEY (id)
);
CREATE SEQUENCE quest_par_format_seq;
CREATE TABLE quest_par_format (
    id integer NOT NULL DEFAULT nextval('quest_par_format_seq'),
    format varchar(20) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE question_par (
    quiz_id integer NOT NULL REFERENCES quiz(id),
    quest_num integer NOT NULL,
    quest_text TEXT,
    format_id integer REFERENCES quest_par_format(id),
    PRIMARY KEY (quiz_id, quest_num)
);
CREATE TABLE correct_answer (
	quiz_id integer NOT NULL,
	quest_num integer NOT NULL,
	word_ind integer NOT NULL,
	corr_ans varchar(45),
	PRIMARY KEY (quiz_id, quest_num, word_ind),
	--INDEX quiz_ind (quiz_id),
	FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE
);
CREATE SEQUENCE draggable_seq;
CREATE TABLE draggable (
    id integer NOT NULL DEFAULT nextval('draggable_seq'),
    quiz_id integer NOT NULL,
    draggable varchar(45),
    disp_order integer,
    PRIMARY KEY (id),
    --INDEX quiz_ind (quiz_id),
	FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE
);
CREATE SEQUENCE role_seq;
CREATE TABLE role (
    id integer NOT NULL DEFAULT nextval('role_seq'),
    "role" varchar(20) UNIQUE NOT NULL,
    PRIMARY KEY (id)
);
CREATE SEQUENCE user_seq;
CREATE TABLE "user" (
	id integer NOT NULL DEFAULT nextval('user_seq'),
	user_name varchar(25) UNIQUE,
	first_name varchar(45),
	last_name varchar(45),
	password varchar(20) NOT NULL,
	"role" varchar(20) NOT NULL,
	email varchar(60),
    created TIMESTAMP NULL,
    modified TIMESTAMP NULL,
	PRIMARY KEY (id)
);
CREATE SEQUENCE course_seq;
CREATE TABLE course (
    id integer NOT NULL DEFAULT nextval('course_seq'),
	course_num varchar(45),
	title varchar(60),
	section varchar(20),
	semester varchar(20),
	year varchar(4),
    created TIMESTAMP NULL,
    modified TIMESTAMP NULL,
	PRIMARY KEY (id)
);
CREATE TABLE quiz_course (
	quiz_id integer NOT NULL,
	course_id integer NOT NULL,
	PRIMARY KEY (quiz_id, course_id),
	--INDEX quiz_ind (quiz_id),
	FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE,
	--INDEX course_ind (course_id),
	FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE
);
CREATE SEQUENCE unit_seq;
CREATE TABLE unit (
	id integer NOT NULL DEFAULT nextval('unit_seq'),
	course_id integer NOT NULL,
	title varchar(60),
	descrip TEXT,
	schedule varchar(45),
	PRIMARY KEY (id)
);
CREATE TABLE quiz_unit (
	quiz_id integer NOT NULL,
	unit_id integer NOT NULL,
	PRIMARY KEY (quiz_id, unit_id),
	--INDEX quiz_ind (quiz_id),
	FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE,
	--INDEX unit_ind (unit_id),
	FOREIGN KEY (unit_id) REFERENCES unit(id) ON DELETE CASCADE
);
CREATE TABLE user_course (
	user_id integer NOT NULL,
	course_id integer NOT NULL,
	PRIMARY KEY (user_id, course_id),
	--INDEX user_ind (user_id),
	FOREIGN KEY (user_id) REFERENCES "user"(id) ON DELETE CASCADE,
	--INDEX course_ind (course_id),
	FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE
);
CREATE TABLE quiz_attempt (
	user_id integer NOT NULL,
	quiz_id integer NOT NULL,
	attemptNum integer NOT NULL,
	score varchar(20),
	taker_ans TEXT,
	date_time TIMESTAMP,
	PRIMARY KEY (user_id, quiz_id, attemptNum),
	--INDEX user_ind (user_id),
	FOREIGN KEY (user_id) REFERENCES "user"(id) ON DELETE CASCADE,
	--INDEX quiz_ind (quiz_id),
	FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE
);

# --- !Downs

DROP TABLE quiz_attempt;
DROP TABLE user_course;
DROP TABLE quiz_unit;
DROP TABLE unit;
DROP TABLE quiz_course;
DROP TABLE course;
DROP TABLE "user";
DROP TABLE "role";
DROP TABLE draggable;
DROP TABLE correct_answer;
DROP TABLE question_par;
DROP TABLE quest_par_format;
DROP TABLE quiz;

DROP SEQUENCE quiz_seq;
DROP SEQUENCE quest_par_format_seq;
DROP SEQUENCE draggable_seq;
DROP SEQUENCE role_seq;
DROP SEQUENCE user_seq;
DROP SEQUENCE course_seq;
DROP SEQUENCE unit_seq;


