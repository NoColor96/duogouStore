//懒加载实现
$(document).ready(function(){
	//给所有需要懒加载的图片加上加载中样式
	$(".lazyLoad").attr("src","../img/site/loading.gif");
});
window.onload = function(){
		let imgs = $("img[data-src]");
		var preIs = 0;//上次滑动总距离
		function lazyLoad(){
			var innerHeight = window.innerHeight;
			var scrollTop = document.body.scrollTop;
			var is = window.innerHeight+document.body.scrollTop;//可视区域的高度+到顶部的距离=滑动总距离
			if(preIs > is) return false;//若此次滑动总距离小于上次滑动总距离，则表示为上划，上划不调用懒加载
				for(var i = 0;i < imgs.length;i++){
					if(imgs[i].offsetTop<=is){
						imgs[i].src = imgs[i].getAttribute("data-src");
						imgs.splice(i,1);
						i--;
					}
				}
			preIs = is;
		}
	lazyLoad();
	window.addEventListener("scroll",debounce(lazyLoad,66));
	function debounce(func,wait){//防抖函数
		var timeout;
		return function(){
			clearTimeout(timeout);
			timeout = setTimeout(func,wait);
		}
	}

}