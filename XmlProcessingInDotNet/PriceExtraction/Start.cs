namespace PriceExtraction
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Xml;
    using System.Xml.Linq;

    public class Start
    {
        public static void Main()
        {
            var pricesUsingXpath = ExtractPricesUsingXpath(2000);
            foreach (var p in pricesUsingXpath)
            {
                Console.WriteLine(p);
            }

            Console.WriteLine();

            var pricesUsingLinq = ExtractPricesUsingLinq(2000);
            foreach (var p in pricesUsingLinq)
            {
                Console.WriteLine(p);
            }
        }

        private static IEnumerable<decimal> ExtractPricesUsingXpath(int maxYear)
        {
            var prices = new List<decimal>();

            var doc = new XmlDocument();
            doc.Load("../../../AdditionalFiles/catalog.xml");

            string query = "albums/album";
            XmlNodeList albums = doc.SelectNodes(query);
            foreach (XmlNode album in albums)
            {
                int currentYear = Convert.ToInt32(album.SelectSingleNode("year").InnerText);
                if (currentYear < maxYear)
                {
                    decimal currentPrice = Convert.ToDecimal(album.SelectSingleNode("price").InnerText);
                    prices.Add(currentPrice);
                }
            }

            return prices;
        }

        private static IEnumerable<decimal> ExtractPricesUsingLinq(int maxYear)
        {
            var doc = XDocument.Load("../../../AdditionalFiles/catalog.xml");

            var prices = from album in doc.Descendants("album")
                         where (int)album.Element("year") < maxYear
                             select Convert.ToDecimal(album.Element("price").Value);

            return prices;
        }
    }
}
