namespace StudentsSystem.Data.Migrations
{
    using System.Data.Entity.Migrations;

    using Models;

    public sealed class Configuration : DbMigrationsConfiguration<StudentsSystemDbContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.AutomaticMigrationDataLossAllowed = false;
            this.ContextKey = "StudentsSystem.Data.StudentsSystemDbContext";
        }

        protected override void Seed(StudentsSystemDbContext context)
        {
            context.Courses.AddOrUpdate(
                c => c.Name,
                new Course { Name = "CSharp" },
                new Course { Name = "JS Apps" });
        }
    }
}
