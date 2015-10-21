namespace NorthwindDb
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public static class CustomersDAO
    {
        public static void Insert(Customer customer)
        {
            if (customer == null)
            {
                throw new ArgumentNullException("Customer cannot be null.");
            }

            if (string.IsNullOrWhiteSpace(customer.CustomerID))
            {
                throw new ArgumentException("CustomerID is mandatory.");
            }

            using (var dbContext = new NorthwindEntities())
            {
                dbContext.Customers.Add(customer);
                dbContext.SaveChanges();
            }
        }

        public static void Modify(string id, string newContactName)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                throw new ArgumentException("Id is null, empty or contains only whitespaces.");
            }

            string trimmedId = id.Trim();

            using (var dbContext = new NorthwindEntities())
            {
                var customer = dbContext.Customers
                                .Where(c => c.CustomerID.Equals(trimmedId))
                                .FirstOrDefault();

                if (customer == null)
                {
                    throw new ArgumentException("Id not found.");
                }

                customer.ContactName = newContactName;
                dbContext.SaveChanges();
            }
        }

        public static void Delete(string id)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                throw new ArgumentException("Id is null, empty or contains only whitespaces.");
            }

            string trimmedId = id.Trim();

            using (var dbContext = new NorthwindEntities())
            {
                var customer = dbContext.Customers
                                .Where(c => c.CustomerID.Equals(trimmedId))
                                .FirstOrDefault();

                if (customer == null)
                {
                    throw new ArgumentException("Id not found.");
                }

                dbContext.Customers.Remove(customer);
                dbContext.SaveChanges();
            }
        }

        public static IEnumerable<object> FindAllWithOrdersByShippedDateAndShipCountry(DateTime shippedDate, string shipCountry)
        {
            string shipCountryLowered = shipCountry.ToLower();

            using (var dbContext = new NorthwindEntities())
            {
                return dbContext.Customers
                        .Where(c => c.Orders.Any(o => (o.ShippedDate.Value.Year == shippedDate.Year) 
                            && (o.ShipCountry.ToLower() == shipCountryLowered)))
                        .Select(c => new { c.CompanyName, c.ContactName })
                        .ToList();
            }
        }
    }
}
