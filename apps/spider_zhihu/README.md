spider_zhihu
============

Erlang一个简单的爬虫程序

运行:
spider:start_link(). 
%每天凌晨6点启动任务抓取网页

模块调用关系:
spider.erl -> spider_conf -> spider_http -> spider_action -> spider_dom

这只是一个小例子，目前没有扩展。只能抓取特定的（目前只能抓取知乎）网页。

放上来，只是给大家提供一个思路。

这个爬虫小程序包含：

1.生成Url，获取Url

2.抓取网页，并把网页保存到本地

3.解析网页，获取有用的信息

4.入库。
