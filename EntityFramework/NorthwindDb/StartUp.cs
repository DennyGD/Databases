namespace NorthwindDb
{
    using System;
    using System.Linq;

    public class StartUp
    {
        public static void Main()
        {
            // InsertModifyDeleteCustomers();

            // FindAllCustomersWithOrdersIn1997ToCanada();

            // FindAllCustomersWithOrdersIn1997ToCanadaUsingSql();

            // FindAllOrdersByRegionAndPeriod("Nueva Esparta", new DateTime(1994, 1, 1), new DateTime(2000, 1, 1));

            // TestMultipleDbContexts();
        }

        private static void InsertModifyDeleteCustomers()
        {
            string newCustomerId = "GJDMA";

            var newCustomer = new Customer()
            {
                CustomerID = newCustomerId,
                CompanyName = "Google",
                ContactName = "Jane Doe",
                City = "Melbourne",
                Country = "Australia"
            };

            CustomersDAO.Insert(newCustomer);

            CustomersDAO.Modify(newCustomerId, "Janey Doe");

            CustomersDAO.Delete(newCustomerId);
        }

        private static void FindAllCustomersWithOrdersIn1997ToCanada()
        {
            var wantedDate = new DateTime(1997, 1, 1);
            string wantedCountry = "Canada";
            var foundCustomers = CustomersDAO.FindAllWithOrdersByShippedDateAndShipCountry(wantedDate, wantedCountry);

            foreach (var customer in foundCustomers)
            {
                Console.WriteLine(customer);
            }

            Console.WriteLine();

            /* To verify the results in SQL Server:
            SELECT DISTINCT(c.CompanyName) AS [Company Name],
              c.ContactName AS[Contact Name],
              o.ShipCountry AS[Country]
            FROM Customers c
            JOIN Orders o
            ON c.CustomerID = o.CustomerID
            WHERE o.ShipCountry = 'Canada'
                AND DATEPART(yyyy, o.ShippedDate) = '1997'*/
        }

        private static void FindAllCustomersWithOrdersIn1997ToCanadaUsingSql()
        {
            string query = @"SELECT DISTINCT(c.CompanyName)
                            FROM Customers c
                            JOIN Orders o
                            ON c.CustomerID = o.CustomerID
                            WHERE o.ShipCountry = 'Canada'
                                AND DATEPART(yyyy, o.ShippedDate) = '1997'";

            using (var dbContext = new NorthwindEntities())
            {
                var foundCustomers = dbContext.Database.SqlQuery<string>(query).ToList();

                foreach (var c in foundCustomers)
                {
                    Console.WriteLine(c);
                }

                Console.WriteLine();
            }
        }

        private static void FindAllOrdersByRegionAndPeriod(string region, DateTime startDate, DateTime endDate)
        {
            string regionLowered = region.ToLower();

            using (var dbContext = new NorthwindEntities())
            {
                var foundOrders = dbContext.Orders
                                            .Where(o => (o.ShipRegion.ToLower() == regionLowered)
                                            && (o.OrderDate > startDate && o.OrderDate < endDate))
                                            .Select(o => new { o.OrderDate, o.ShipRegion })
                                            .ToList();

                foreach (var order in foundOrders)
                {
                    Console.WriteLine(order);
                }
            }
        }

        // Separate contexts at the same time are appropriate if they are for completely unrelated modules.
        // In the example below the changes made by the second db context override the changes from the first one.
        private static void TestMultipleDbContexts()
        {
            var firstDbContext = new NorthwindEntities();
            var secondDbContext = new NorthwindEntities();

            var firstCategoryFirstContext = firstDbContext.Categories.FirstOrDefault();
            var firstCategorySecondContext = secondDbContext.Categories.FirstOrDefault();

            firstCategoryFirstContext.CategoryName = "Drinks";
            firstCategorySecondContext.CategoryName = "Override drinks";

            firstDbContext.SaveChanges();
            secondDbContext.SaveChanges();
        }
    }
}