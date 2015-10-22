namespace StudentsSystem.ConsoleClient
{
    using System.Data.Entity;
    using System.Linq;

    using Data;
    using Data.Migrations;
    using Models;

    public class StartUp
    {
        public static void Main()
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<StudentsSystemDbContext, Configuration>());

            //// TODO Students have homeworks added but they don't have courses

            AddCourses(100);
            AddStudents(250);
            AddHomeworks(200);
        }

        private static void AddCourses(int coursesCount)
        {
            //// It's no good if count > 100

            using (var dbContext = new StudentsSystemDbContext())
            {
                for (int i = 0; i < coursesCount; i++)
                {
                    var course = new Course();
                    course.Name = RandomDataGenerator.GetString(2, 50);

                    dbContext.Courses.Add(course);
                }

                dbContext.SaveChanges();
            }
        }

        private static void AddStudents(int studentsCount)
        {
            var dbContext = new StudentsSystemDbContext();

            for (int i = 0; i < studentsCount; i++)
            {
                var student = new Student();
                student.FirstName = RandomDataGenerator.GetString(2, 10);
                student.LastName = RandomDataGenerator.GetString(2, 15);
                student.FacultyNumber = RandomDataGenerator.GetString(10, 10);

                dbContext.Students.Add(student);

                if (i % 100 == 0)
                {
                    dbContext.SaveChanges();
                    dbContext.Dispose();
                    dbContext = new StudentsSystemDbContext();
                }
            }

            dbContext.SaveChanges();
        }

        private static void AddHomeworks(int homeworksCount)
        {
            var dbContext = new StudentsSystemDbContext();

            var coursesIds = dbContext.Courses
                                    .Select(c => c.Id)
                                    .ToList();
            
            int coursesIdsCount = coursesIds.Count;

            var studentsIds = dbContext.Students
                                    .Select(st => st.Id)
                                    .ToList();

            for (int i = 0; i < homeworksCount; i++)
            {
                var hw = new Homework();
                hw.Content = RandomDataGenerator.GetString(1, 500);

                int courseIndex = RandomDataGenerator.GetInteger(0, coursesIdsCount - 1);
                hw.CourseId = coursesIds[courseIndex];

                // works while students count is equal or greater than homeworks count
                hw.StudentId = studentsIds[i];

                dbContext.Homeworks.Add(hw);

                if (i % 100 == 0)
                {
                    dbContext.SaveChanges();
                    dbContext.Dispose();
                    dbContext = new StudentsSystemDbContext();
                }
            }

            dbContext.SaveChanges();
        }
    }
}
