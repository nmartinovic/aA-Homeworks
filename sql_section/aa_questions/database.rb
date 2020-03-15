=begin
The next thing to work on is User#average_karma


=end

require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end

end

class User

    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| User.new(datum) }
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL,id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL

        User.new(user.first)
    end

    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute(<<-SQL,fname, lname)
        SELECT
            *
        FROM
            users
        WHERE fname = ? AND lname = ?
        SQL
        User.new(user.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        Question.find_by_author_id(@id)
    end

    def authored_replies
        Reply.find_by_user_id(@id)
    end

    def followed_questions
        Question_Follow.followed_questions_for_user_id(@id)
    end

    def liked_questions
        Question_Like.liked_questions_for_user_id(@id)
    end

    def average_karma
        karma = QuestionsDatabase.instance.execute(<<-SQL,@id)
        SELECT
            users.fname, users.lname, CAST(COUNT(DISTINCT(question_likes.id))/COUNT(DISTINCT(questions.id)) AS FLOAT)
        FROM
            users
        JOIN questions
        ON questions.user_id = users.id
        JOIN question_likes
        ON question_likes.question_id = questions.id
        WHERE
            users.id = ?
        GROUP BY
            users.fname, users.lname
        SQL
        karma
    end

    def save
        if @id == nil
            QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
            INSERT INTO 
                users (fname, lname)
            VALUES
            (?,?)

            SQL
            @id = QuestionsDatabase.instance.last_insert_row_id
        else
            QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
                UPDATE
                    users
                SET
                    fname = ?, lname = ?
                WHERE
                    id = ?
            SQL
        end
    end
end

class Question
    attr_accessor :id, :title, :body, :user_id
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Question.new(datum)}
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL,id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        Question.new(question.first)
    end

    def self.find_by_author_id(author_id)
        author_entries = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                user_id = ?
        SQL
        author_entries.map { | datum| Question.new(datum)}
    end

    def self.most_liked(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                q.id, q.title, q.body, q.user_id
            FROM
                questions q
            JOIN
                question_likes ql
            ON
                q.id = ql.question_id
            GROUP BY
                q.id
            ORDER BY 
                COUNT(ql.id)
            LIMIT ?
        SQL

        questions.map { |question| Question.new(question)}
    end

    def self.most_followed(n)
        Question_Follow.most_followed_questions(n)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @user_id = options['user_id']
    end

    def author
        User.find_by_id(@user_id)
    end

    def replies
        Reply.find_by_question_id(@id)
    end


    def followers
        Question_Follow.followers_for_question_id(@id)
    end

    def likers
        Question_Like.likers_for_question_id(@id)
    end

    def num_likes
        Question_Like.num_likes_for_question_id(@id)
    end


end

class Question_Follow

    attr_accessor :id, :question_id, :user_id

    def self.all
        question_follow = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        question_follow.map { |datum| Question_Follow.new(datum)}
    end

    def self.find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE id = ?
        SQL
        Question_Follow.new(question_follow)
    end

    def self.followers_for_question_id(question_id)
        followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            users.id, users.fname, users.lname
        FROM
            users
        JOIN
            question_follows
        ON users.id = question_follows.user_id
        WHERE
            question_id = ?
        SQL
        followers.map { |follower| User.new(follower)}
    end

    def self.followed_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            questions.id, questions.title, questions.body, questions.user_id
        FROM
            questions
        JOIN
            question_follows
        ON  question_follows.question_id = questions.id
        WHERE
            question_follows.user_id = ?
        SQL
        questions.map { |question| Question.new(question)}
    end

    def self.most_followed_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL,n)
            SELECT
                questions.id, questions.title, questions.body, questions.user_id,count(question_follows.user_id)
            FROM
                question_follows
            JOIN
                questions
            ON questions.id = question_follows.question_id
            GROUP BY
                questions.id
            LIMIT ?
        SQL
        questions.map { |datum| Question.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end


end

class Reply

    attr_accessor :id, :body, :parent_id, :user_id, :question_id

    def self.all
        reply = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        reply.map { |datum| Reply.new(datum)}
    end

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?
        SQL
        Reply.new(reply.first)
    end

    def self.find_by_user_id(user_id)
        user_replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL

        user_replies.map { |datum| Reply.new(datum)}
    end

    def self.find_by_question_id(question_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = ?
        SQL
        questions.map { |datum| Reply.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @parent_id = options['parent_id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def author
        User.find_by_author_id(@user_id)
    end

    def question
        Question.find_by_id(@question_id)
    end

    def parent_reply
        parent_reply = QuestionsDatabase.instance.execute(<<-SQL, @parent_id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        Reply.new(parent_reply.first)
    end

    def child_replies
        child_reply = QuestionsDatabase.instance.execute(<<-SQL,id)
            SELECT 
                *
            FROM
                replies
            WHERE
                parent_id = ?
        SQL
        Reply.new(child_reply.first)
    end
end

class Question_Like

    attr_accessor :id, :user_id, :question_id

    def self.all
        question_like = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        question_like.map { |datum| Question_Like.new(datum) }
    end

    def self.find_by_id(id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_likes
        WHERE
            id = ?
        SQL
        Question_like.new(question_like)
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def self.likers_for_question_id(question_id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL,question_id)
            SELECT
                users.id, users.fname, users.lname
            FROM
                users
            JOIN
                question_likes
            ON question_likes.user_id = users.id
            WHERE
                question_likes.question_id = ?
        SQL
        question_like.map { |datum| User.new(datum)}
    end

    def self.num_likes_for_question_id(question_id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                question_likes.question_id, count(id)
            FROM
                question_likes
            WHERE
                question_likes.question_id = ?
            GROUP BY
                question_likes.question_id
        SQL
        question_like
    end

    def self.liked_questions_for_user_id(user_id)
        liked_questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT 
                q.id, q.title, q.body, q.user_id
            FROM
                questions q
            JOIN
                question_likes ql
            ON
                q.id = ql.question_id
            WHERE ql.user_id = ?
        SQL
        liked_questions.map { |datum| Question.new(datum)}
    end

    def self.most_liked_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                q.id, q.title, q.body, q.user_id
            FROM
                questions q
            JOIN
                question_likes ql
            ON
                q.id = ql.question_id
            GROUP BY
                q.id
            ORDER BY 
                COUNT(ql.id)
            LIMIT ?
        SQL

        questions.map { |question| Question.new(question)}
    end

end


