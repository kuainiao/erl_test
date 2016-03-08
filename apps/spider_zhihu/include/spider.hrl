-record( spider_url, {url, filePath, title} ).

-define( URL_CONF, [
	{"http://www.zhihu.com/topic/19550994/questions", "1", "游戏"},
	{"http://www.zhihu.com/topic/19553361/questions", "2", "游戏开发"},
	{"http://www.zhihu.com/topic/19600554/questions", "3", "游戏产业"},
	{"http://www.zhihu.com/topic/19551648/questions", "4", "游戏设计"},
	{"http://www.zhihu.com/topic/19561656/questions", "5", "游戏设计师"},
	{"http://www.zhihu.com/topic/19672960/questions", "6", "游戏编程"},
	{"http://www.zhihu.com/topic/19646175/questions", "7", "游戏交互设计"},
	{"http://www.zhihu.com/topic/19555490/questions", "8", "手机游戏"},
	{"http://www.zhihu.com/topic/19554968/questions", "9", "网页游戏"},	
	{"http://www.zhihu.com/topic/19740084/questions", "10", "网页游戏运营"},
	{"http://www.zhihu.com/topic/19567820/questions", "11", "游戏运营"},	
	
	{"http://www.zhihu.com/topic/19557564/questions", "12", "HTML5"},
	{"http://www.zhihu.com/topic/19574057/questions", "13", "HTML 5 游戏"},	
	
	{"http://www.zhihu.com/topic/19551557/questions", "14", "设计"},
	{"http://www.zhihu.com/topic/19556382/questions", "15", "平面设计"},
	
	{"http://www.zhihu.com/topic/19564127/questions", "16", "计算机技术"},
	{"http://www.zhihu.com/topic/19556498/questions", "17", "信息技术（IT）"},
	
	{"http://www.zhihu.com/topic/19606610/questions", "18", "Erlang（编程语言）"},
	
	
	{"http://www.zhihu.com/collection/19649021", "19", "醍醐灌顶"},
	{"http://www.zhihu.com/collection/19845231", "20", "心理学应用与拓展"},
	{"http://www.zhihu.com/collection/19649022", "21", "hello world！"},
	{"http://www.zhihu.com/collection/19649007", "22", "产品运营"},
				   
	{"http://www.zhihu.com/collection/19649030", "23", "神吐槽"},
{"http://www.zhihu.com/collection/19691013", "24", "神展开"},
{"http://www.zhihu.com/collection/19688585", "25", "神翻译"},
{"http://www.zhihu.com/collection/19699710", "26", "神类比"},
{"http://www.zhihu.com/collection/19821165", "27", "神引用"},
{"http://www.zhihu.com/collection/19826237", "28", "神转折"},
{"http://www.zhihu.com/collection/25830319", "29", "一万票回答"},
{"http://www.zhihu.com/collection/19668455", "30", "赞同数超过1024的回答"},
{"http://www.zhihu.com/collection/19696655", "31", "被收藏1024次以上的回答"},
{"http://www.zhihu.com/collection/39203030", "32", "挽救答主的尊严"},
{"http://www.zhihu.com/collection/24079461", "33", "各种新奇的角度"},
{"http://www.zhihu.com/collection/19687868", "34", "一定是我打开的方式不对"},
{"http://www.zhihu.com/collection/19696621", "35", "实践是检验真理的唯一标准"}
]).