<extend name="Public/base" />
<block name="css">

    <style type="text/css">
        body{ margin:0; font-family:"微软雅黑";}
        html,body,#wrapper{ height:100%;}
     
        .wrapper{ background: white !important;}
        .content{ position: relative;}
        .allmap{ position: absolute; left:0px; right:0; top:50px; bottom:0;}
        .panel-heading{ padding:10px 25px !important;}
        .fa-paper-plane{ margin-left:-50px;}
        p{ margin-left:5px; font-size:14px;}
        .sections{ position:absolute; z-index:20; top:80px; right:40px;}
        .section{ width:220px; min-height: 120px; margin:0;}
        .huge{ font-size:20px}
    </style>

    <!-- Morris Charts CSS -->
    <!-- <link rel="stylesheet" href="__Assert__/css/bootstrap.min.css" rel="stylesheet" > -->
</block>
<block name="content">
    	<!-- <div class="panel panel-info"> -->
        <div id="allmap" class="allmap"></div>  
        <div class="sections">
            <div class="section">   
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <span class="pull-left">门店</span>
                        </div>
                    </div>
                    <div class="panel-body">
                        
                        <div class="col-xs-10 text-left">
                            <div class="huge">{$s_count}家</div>
                            <div>共有门店</div>
                        </div>
                        <div class="col-xs-2">
                            <i class="fa fa-paper-plane fa-5x"></i>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="section">   
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <span class="pull-left">客服</span>
                        </div>
                    </div>
                    <div class="panel-body">
                        
                        <div class="col-xs-10 text-left">
                            <div class="huge">{$u_count}名</div>
                            <div>共有客服</div>
                        </div>
                        <div class="col-xs-2">
                            <i class="fa fa-paper-plane fa-5x"></i>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="section">   
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <span class="pull-left">会员</span>
                        </div>
                    </div>
                    <div class="panel-body">
                        
                        <div class="col-xs-10 text-left">
                            <div class="huge">{$v_count}名</div>
                            <div>共有会员</div>
                        </div>
                        <div class="col-xs-2">
                            <i class="fa fa-paper-plane fa-5x"></i>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="section">   
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="row">
                            <span class="pull-left">营业额</span>
                        </div>
                    </div>
                    <div class="panel-body">
                        
                        <div class="col-xs-10 text-left">
                            <div class="huge">{$f_money}元</div>
                            <div>今日营业额</div>
                        </div>
                        <div class="col-xs-2">
                            <i class="fa fa-paper-plane fa-5x"></i>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
		    
		</div>
     

        
</block>
<block name="js">
 <!-- Morris Charts JavaScript -->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=uiwx7N7FhYKGNqCxVGjCGcMPPrivr6fE"></script>

<script type="text/javascript">
        // 百度地图API功能    
        var map = new BMap.Map("allmap");
        map.centerAndZoom(new BMap.Point(108.417854,34.921988), 5);  //（116.417854,39.921988）是中心点。5是地图的缩放级别

        // setTimeout(function(){
        //  map.centerAndZoom(new BMap.Point(113.262232,23.154345), 12); 
        // },3000);
        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
        var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
        map.addControl(top_left_control);        
        map.addControl(top_left_navigation); 
        map.enableScrollWheelZoom(true); //启用滚轮放大缩小 
        

        var data={$data};   //后台发过来的数据
        createContent(data);

// function move(){
//    setTimeout(function(){marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画},1)
// }
        //根据数据添加标注点和信息窗口
        function createContent(data){

            //遍历数据生成标注点和信息窗口
            var len=data.length;

            for(var i=0;i<len;i++){
                var marker = new BMap.Marker(new BMap.Point(data[i].flng,data[i].flat));  // 创建标注

                var title=data[i].sname;
                var content = data[i].saddress;
                map.addOverlay(marker);               // 将标注添加到地图中
                addClickHandler(marker,title,content);
            }
        }    

            //添加信息窗口
            function openInfo(e,title,content){
                var p = e.target;
                var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
                var opts = {
                        width : 250,     // 信息窗口宽度
                        height: 80,     // 信息窗口高度
                        title : title , // 信息窗口标题
                        enableMessage:true//设置允许信息窗发送短息
                    };
                var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象 
                map.openInfoWindow(infoWindow,point); //开启信息窗口
            }


            //点击开启信息窗口
            function addClickHandler(marker,title,content){
                marker.addEventListener("click",function(e){
                    openInfo(e,title,content)
                });
            }


            //添加自定义覆盖物(气泡)
            function addOverlay(point,txt){

                  function ComplexCustomOverlay(point, text){
                      this._point = point;
                      this._text = text;
                  }
                 ComplexCustomOverlay.prototype = new BMap.Overlay();
                 ComplexCustomOverlay.prototype.initialize = function(map){
                      this._map = map;
                      var div = this._div = document.createElement("div");
                      div.style.position = "absolute";
                      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
                      div.style.backgroundColor = "#EE5D5B";
                      div.style.border = "1px solid #BC3B3A";
                      div.style.color = "white";
                      div.style.height = "24px";
                      div.style.padding = "2px 4px";
                      div.style.lineHeight = "18px";
                      div.style.whiteSpace = "nowrap";
                      div.style.MozUserSelect = "none";
                      div.style.fontSize = "14px";
                      div.style.borderRadius="4px";
                      var span = this._span = document.createElement("span");
                      div.appendChild(span);
                      span.appendChild(document.createTextNode(this._text));      
                      var that = this;

                      var arrow = this._arrow = document.createElement("div");
                      arrow.style.background = "url(__Assert__/img/label.png) no-repeat";
                      arrow.style.position = "absolute";
                      arrow.style.width = "11px";
                      arrow.style.height = "10px";
                      arrow.style.top = "22px";
                      arrow.style.left = "10px";
                      arrow.style.overflow = "hidden";
                      div.appendChild(arrow);
                     
                      map.getPanes().labelPane.appendChild(div);
                      
                      return div;
                }
                ComplexCustomOverlay.prototype.draw = function(){
                      var map = this._map;
                      var pixel = map.pointToOverlayPixel(this._point);
                      this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
                      this._div.style.top  = pixel.y - 55 + "px";
                }
                  
                var myCompOverlay = new ComplexCustomOverlay(point, txt);
                map.addOverlay(myCompOverlay);
                setTimeout(function(){
                    map.removeOverlay(myCompOverlay);
                },4000);

            }


</script> 
<script>
   //折叠时地图大小变化
slider();
var width1;
   function slider(){
   //判断是收缩还是展开的
     width1=$('.sidebar').width();
// if($("body").hasClass("slider-collapse")){alert(1);}
// alert($("body").attr("class"))
     if($('.sidebar').width()>=230){
           $('#allmap').css('left',50);
       }else{
           $('#allmap').css('left',230);
       }
   }

   $('.sidebar-toggle').click(function(){
      if($('.sidebar').width()>=230){
           $('#allmap').css('left',50);

       }else{
           $('#allmap').css('left',230);
       }
      
   });
</script>

</block>