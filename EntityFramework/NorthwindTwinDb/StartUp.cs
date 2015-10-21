namespace NorthwindTwinDb
{
    using NorthwindDb;

    public class StartUp
    {
        public static void Main()
        {
            CreateNorthwindTwin();
        }

        // Added a connection string in App.config
        private static void CreateNorthwindTwin()
        {
            using (var dbContext = new NorthwindEntities())
            {
                dbContext.Database.CreateIfNotExists();
            }
        }
    }
}
