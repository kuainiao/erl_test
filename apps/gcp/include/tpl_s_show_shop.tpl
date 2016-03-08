<div class="div3">
	<div class="pro_info_1 left">
		<p>最近30天</p>
		<p class="bgimg see">{{pv_30}}</p>
		<p class="bgimg comment">{{totle_30}}</p>
		<p>未来7天(预计)</p>
		<p class="bgimg see">{{pv_30}}</p>
		<p class="bgimg comment">{{totle_30}}</p>
	</div>
	<div class="pro_info_2 left">
		<div class="pro_img left"><img src="{{img_url}}"/></div>
		<div class="pro_data left">
			<p>{{shop_title}}</p>
			<p><a href="{{shop_url}}" target="_blank" title="查看商品原地址">查看商品原地址</a></p>
		</div>
		<br class="clear"/>
	</div>
	<div class="pro_info_3 left">
		<p>{{shop_name}}</p>
		<p><span>成立:</span>3年</p>
		<p><span>综合评分:</span>{{shop_score}}分</p>
		<p class="button"><a href="{{shop_url}}" target="_blank" ><span>{{websit}}</span><img src="/images/button1.png"/></a></p>
	</div>
	<input type="hidden" value = "{{shop_url}}" id="shop_id"/>
	<br class="clear"/>
</div>

<div class="div4">
	<ul class="com_info left">
		<li class="nav">这个宝贝不错(<i id="gcount">{{gcount}}</i>)</li>
		{% for nowtime,username,review in good %}
		<li title="评论信息：{{review}}">{{username|first}}**{{username|last}}<span>{{nowtime}}前</span></li>
		{% endfor %}
	</ul>
	<div class="com left">
		<div class="nav">给此产品差评</div>
		<div class="com_data">
			<div class="option">
				<span class="select" id="bad_comment">差评(<i id="bcount">{{bcount}}</i>)<span style="position:absolute;height: 10px;width:80px;display:block;top: 30px;left: 12px;background-color: rgb(102,51,204);" id="b_bander"></span></span>
				<span style="margin:0px 16px;">|</span>
				<span style="color: #FF9933;" id="medium_comment">中评(<i id="mcount">{{mcount}}</i>)<span style="position:absolute;height: 10px;width:80px;display:none;top: 30px;left:100px;background-color: rgb(255,153,51);" id="m_bander"></span></span>
			</div>
			<ul id="negative_comment" style="overflow:auto;" class="comment_text">
				{% for nowtime,username,review in bad %}
						<li>
							<p class="head">
								<span style="font-weight: 700;">{{username|first}}**{{username|last}}</span>
								<span style="font-size: 12px;color: #BCBCBC;display: inline-block;float: right;">{{nowtime}}前</span></p>
							<p>{{review}}</p>
						</li>
				{% empty %}
				<li style="text-indent: 20px;">暂无评论</li>
				{% endfor %}
			</ul>
			<ul id="commentary" style="display:none" class="comment_text">
				{% for nowtime,username,review in medium %}
						<li>
							<p class="head">
								<span style="font-weight: 700;">{{username|first}}**{{username|last}}</span>
								<!-- <span style="font-weight: 400;font-size: 11px; color: #999999;"> 中评2次</span> -->
								<span style="font-size: 12px;color: #BCBCBC;display: inline-block;float: right;">{{nowtime}}前</span></p>
							<p>{{review}}</p>
						</li>
				{% empty %}
				<li style="text-indent: 20px;">暂无评论</li>
				{% endfor %}
			</ul>
		</div>
	</div>
	<br class="clear"/>
</div>
