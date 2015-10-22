namespace StudentsSystem.Data
{
    using System.Data.Entity;

    using Models;

    public class StudentsSystemDbContext : DbContext
    {
        public StudentsSystemDbContext()
            : base("StudentsSystemDbContext")
        {
        }

        public virtual IDbSet<Course> Courses { get; set; }
     
        public virtual IDbSet<Homework> Homeworks { get; set; }
 
        public virtual IDbSet<Student> Students { get; set; }
    }
}
