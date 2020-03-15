# Add enrollments and enrolled_students associations. You can infer how to test these based on our previous work.

# Now, things get tricky. Add an association for prerequisite. This should return a course's prereq (if it has one).

# Finally, add an instructor association to Course. This will point to a User object. Note that Course is now related to User in two ways: instructor and enrolled_students.

class Course < ApplicationRecord

    has_many(
        :enrollments,
        class_name: 'Enrollment',
        primary_key: :id,
        foreign_key: "course_id"
    )

    has_many(
        :enrolled_students,
        through: :enrollments,
        source: :user
    )

    belongs_to(
        :prerequisite,
        class_name: 'Course',
        primary_key: :id,
        foreign_key: :prereq_id
    )

    belongs_to(
        :instructor,
        class_name: 'User',
        primary_key: :id,
        foreign_key: :instructor_id
    )
end
