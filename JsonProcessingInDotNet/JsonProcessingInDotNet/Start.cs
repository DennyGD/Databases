namespace JsonProcessingInDotNet
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Net;
    using System.Text;
    using System.Xml.Linq;

    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;

    public class Start
    {
        private static readonly string RssFeedUrl = "https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw";

        private static readonly string RssFeedPath = "../../../AdditionalFiles/feed.xml";

        public static void Main()
        {
            DownloadFile(RssFeedUrl, RssFeedPath);

            string feedJson = XmlToJson(RssFeedPath);

            var videoTitles = GetVideoTitlesFromFeed(feedJson);
            Console.WriteLine("Video titles:");
            Console.WriteLine();
            foreach (var t in videoTitles)
            {
                Console.WriteLine(t);
            }

            var pocos = GetPocosFromJson(feedJson);

            string html = GenerateHtml(pocos);

            using (var writer = new StreamWriter("../../../AdditionalFiles/feed.html"))
            {
                writer.Write(html);
            }
        }

        private static void DownloadFile(string from, string to)
        {
            var webClient = new WebClient();
            webClient.DownloadFile(from, to);
        }

        private static string XmlToJson(string xmlPath)
        {
            var doc = XDocument.Load(xmlPath);

            string json = JsonConvert.SerializeXNode(doc);
            return json;
        }

        private static IEnumerable<string> GetVideoTitlesFromFeed(string feedJson)
        {
            var feedAsJObj = JObject.Parse(feedJson);

            var videoTitles = from e in feedAsJObj["feed"]["entry"]
                              select (string)e["title"];

            return videoTitles;
        }

        private static IEnumerable<dynamic> GetPocosFromJson(string json)
        {
            var feedAsJObj = JObject.Parse(json);   

            var pocos = from e in feedAsJObj["feed"]["entry"]
                              select (new { Name = e["title"], YoutubeId = e["yt:videoId"] });

            return pocos;
        }

        private static string GenerateHtml(IEnumerable<dynamic> pocos)
        {
            string htmlBeginning = "<!DOCTYPE html><html xmlns='http://www.w3.org/1999/xhtml'><head>" 
                + "<meta charset = 'utf-8'/><title>RSS Feed</title>";

            var htmlBuilder = new StringBuilder();
            htmlBuilder.Append(htmlBeginning);
            htmlBuilder.Append("<body>");

            string iframeBeginning = "<iframe width='500' height='500' src='https://www.youtube.com/embed/";

            foreach (var p in pocos)
            {
                htmlBuilder.Append(iframeBeginning + p.YoutubeId + "'></iframe>");
            }

            htmlBuilder.Append("</body></html>");

            return htmlBuilder.ToString();
        }
    }
}