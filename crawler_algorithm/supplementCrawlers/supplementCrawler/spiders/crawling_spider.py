from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor

class CrawlingSpider(CrawlSpider):
    name = "supplementCrawler"
    allowed_domains = ["https://www.webmd.com/", "https://www.drugs.com/"]
    start_urls = ["https://www.webmd.com/"]

    rules = (
        Rule(LinkExtractor(allow="drugs"))
    )