namespace PersonInfoCreation
{
    using System.IO;
    using System.Xml.Linq;

    public class Start
    {
        public static void Main()
        {
            GeneratePersonInfo();
        }

        private static void GeneratePersonInfo()
        {
            var tags = new string[] { "name", "address", "phone" };

            var info = new XElement("info");

            using (var reader = new StreamReader("../../../AdditionalFiles/person-info.txt"))
            {
                for (int i = 0; i < tags.Length; i++)
                {
                    string currentLine = reader.ReadLine();
                    if (currentLine == null)
                    {
                        break;
                    }

                    info.Add(new XElement(tags[i], currentLine));
                }
            }

            info.Save("../../../AdditionalFiles/person-info.xml");
        }
    }
}
