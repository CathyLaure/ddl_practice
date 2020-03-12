USE ctasama;
ALTER DATABASE ctasama CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS articleTag;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS author;

/* author, article,tag: Strong Entity */
CREATE TABLE author(
	authorId BINARY(16) NOT NULL,
	authorActivationToken CHAR(32),
	authorAvatarUrl VARCHAR(255) NOT NULL,
	authorEmail VARCHAR(128) NOT NULL,
	authorHash CHAR(37) NOT NULL,
	authorUsername VARCHAR(32) NOT NULL,
	UNIQUE(authorEmail),
	UNIQUE(authorUsername),
	INDEX(authorEmail),
	PRIMARY KEY(authorId)
);

CREATE TABLE tag(
	tagId BINARY(16) NOT NULL,
	tagName VARCHAR(32) NOT NULL,
	PRIMARY KEY(tagId)
);

CREATE TABLE article(
	articleId BINARY(16) NOT NULL,
	articleAuthorId Binary(16) NOT NULL,
	articleContent VARCHAR(4000) NOT NULL,
	articleDate DATETIME(6) NOT NULL,
	articleImage VARCHAR(235),
	INDEX(articleAuthorId),
	FOREIGN KEY (articleAuthorId) REFERENCES author(authorId),
	PRIMARY KEY(articleId)
);

/* articleTag:weak entity */
CREATE TABLE articleTag(
	articleTagArticleId Binary(16) Not Null,
	articleTagTagId BINARY(16) NOT NULL,
	INDEX(articleTagArticleId),
	INDEX(articleTagTagId),
	FOREIGN KEY(articleTagArticleId) REFERENCES article(articleId),
	FOREIGN KEY(articleTagTagId) REFERENCES tag(tagId),
	PRIMARY KEY(articleTagArticleId, articleTagTagId)
);