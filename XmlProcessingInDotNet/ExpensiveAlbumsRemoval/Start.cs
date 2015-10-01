namespace ExpensiveAlbumsRemoval
{
    using System;
    using System.IO;
    using System.Xml;

    public class Start
    {
        public static void Main()
        {
            DeleteExpensiveAlbums(20);
        }

        private static void DeleteExpensiveAlbums(decimal maxPrice)
        {
            var doc = new XmlDocument();
            doc.Load("../../../AdditionalFiles/catalog.xml");
            XmlNode root = doc.DocumentElement;

            foreach (XmlNode album in root.ChildNodes)
            {
                decimal currentPrice = Convert.ToDecimal(album["price"].InnerText);
                if (currentPrice > maxPrice)
                {
                    album.RemoveAll();
                }
            }

            doc.Save("../../../AdditionalFiles/catalog-copy.xml");
        }
    }
}
