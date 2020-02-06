CREATE TABLE USERS (
  USER_ID NUMBER,
  FIRST_NAME VARCHAR2(100) NOT NULL,
  LAST_NAME VARCHAR2(100) NOT NULL,
  YEAR_OF_BIRTH INTEGER,
  MONTH_OF_BIRTH INTEGER,
  DAY_OF_BIRTH INTEGER,
  GENDER VARCHAR2(100),
  PRIMARY KEY(USER_ID)
);

CREATE TABLE FRIENDS (
  USER1_ID NUMBER,
  USER2_ID NUMBER,
  FOREIGN KEY(USER1_ID, USER2_ID) REFERENCES USERS,
);

CREATE TRIGGER order_friends_pairs
  BEFORE INSERT ON FRIENDS
  FOR EACH ROW
    DECLARE temp NUMBER;
    BEGIN
      IF :NEW.USER1_ID > :NEW.USER2_ID THEN
        temp := :NEW.USER2_ID;
        :NEW.USER2_ID := :NEW.USER1_ID;
        :NEW.USER1_ID := temp;
      END IF;
    END;
/


CREATE TABLE CITIES (
  CITY_ID INTEGER,
  CITY_NAME VARCHAR2(100) NOT NULL,
  STATE_NAME VARCHAR2(100) NOT NULL,
  COUNTRY_NAME VARCHAR2(100) NOT NULL,
  PRIMARY KEY(CITY_ID),
  UNIQUE(CITY_NAME, STATE_NAME, COUNTRY_NAME)
);

CREATE TABLE USER_CURRENT_CITIES (
  USER_ID NUMBER,
  CURRENT_CITY_ID INTEGER,
  FOREIGN KEY(USER_ID) REFERENCES USERS,
  FOREIGN KEY(CURRENT_CITY_ID) REFERENCES CITIES
);

CREATE TABLE USER_HOMETOWN_CITIES (
  USER_ID NUMBER,
  HOMETOWN_CITY_ID INTEGER,
  FOREIGN KEY(USER_ID) REFERENCES USERS,
  FOREIGN KEY(HOMETOWN_CITY_ID) REFERENCES CITIES
);

CREATE TABLE MESSAGES (
  MESSAGE_ID NUMBER,
  SENDER_ID NUMBER,
  RECEIVER_ID NUMBER,
  MESSAGE_CONTENT VARCHAR2(2000) NOT NULL,
  SENT_TIME TIMESTAMP NOT NULL,
  PRIMARY KEY(MESSAGE_ID),
  FOREIGN KEY(SENDER_ID) REFERENCES USERS,
  FOREIGN KEY(RECEIVER_ID) REFERENCES USERS
);

CREATE TABLE PROGRAMS (
  PROGRAM_ID INTEGER,
  INSTITUTION VARCHAR2(100) NOT NULL,
  CONCENTRATION VARCHAR2(100) NOT NULL,
  DEGREE VARCHAR2(100) NOT NULL,
  PRIMARY KEY(PROGRAM_ID),
  UNIQUE(INSTITUTION, CONCENTRATION, DEGREE)
);

CREATE TABLE EDUCATION (
  USER_ID NUMBER,
  PROGRAM_ID INTEGER,
  PROGRAM_YEAR INTEGER NOT NULL,
  FOREIGN KEY(USER_ID) REFERENCES USERS,
  FOREIGN KEY(PROGRAM_ID) REFERENCES PROGRAMS
);

CREATE TABLE USER_EVENTS (
  EVENT_ID NUMBER,
  EVENT_CREATOR_ID NUMBER,
  EVENT_NAME VARCHAR2(100) NOT NULL,
  EVENT_TAGLINE VARCHAR2(100),
  EVENT_DESCRIPTION VARCHAR2(100),
  EVENT_HOST VARCHAR2(100),
  EVENT_TYPE VARCHAR2(100),
  EVENT_SUBTYPE VARCHAR2(100),
  EVENT_ADDRESS VARCHAR2(2000),
  EVENT_CITY_ID INTEGER,
  EVENT_START_TIME TIMESTAMP,
  EVENT_END_TIME TIMESTAMP,
  PRIMARY KEY(EVENT_ID),
  FOREIGN KEY(EVENT_CREATOR_ID) REFERENCES USERS,
  FOREIGN KEY(EVENT_CITY_ID) REFERENCES CITIES
);

CREATE TABLE PARTICIPANTS (
  EVENT_ID NUMBER,
  USER_ID NUMBER,
  CONFIRMATION VARCHAR2(100) NOT NULL,
  FOREIGN KEY(EVENT_ID) REFERENCES USER_EVENTS,
  FOREIGN KEY(USER_ID) REFERENCES USERS
);

CREATE TABLE ALBUMS (
  ALBUM_ID NUMBER,
  ALBUM_OWNER_ID NUMBER,
  ALBUM_NAME VARCHAR2(100) NOT NULL,
  ALBUM_CREATED_TIME TIMESTAMP NOT NULL,
  ALBUM_MODIFIED_TIME TIMESTAMP,
  ALBUM_LINK VARCHAR2(100) NOT NULL,
  ALBUM_VISIBILITY VARCHAR2(100) NOT NULL,
  COVER_PHOTO_ID NUMBER,
  PRIMARY KEY(ALBUM_ID),
  FOREIGN KEY(ALBUM_OWNER_ID) REFERENCES USERS,
  FOREIGN KEY(COVER_PHOTO_ID) REFERENCES PHOTOS
);

CREATE TABLE PHOTOS (
  PHOTO_ID NUMBER,
  ALBUM_ID NUMBER,
  PHOTO_CAPTION VARCHAR2(2000),
  PHOTO_CREATED_TIME TIMESTAMP NOT NULL,
  PHOTO_MODIFIED_TIME TIMESTAMP,
  PHOTO_LINK VARCHAR2(2000) NOT NULL,
  PRIMARY KEY(PHOTO_ID),
  FOREIGN KEY(ALBUM_ID) REFERENCES ALBUMS
);

CREATE TABLE TAGS (
  TAG_PHOTO_ID NUMBER,
  TAG_SUBJECT_ID NUMBER,
  TAG_CREATED_TIME TIMESTAMP NOT NULL,
  TAG_X NUMBER NOT NULL,
  TAG_Y NUMBER NOT NULL,
  FOREIGN KEY(TAG_PHOTO_ID) REFERENCES PHOTOS,
  FOREIGN KEY(TAG_SUBJECT_ID) REFERENCES USERS
);