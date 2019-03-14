<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Map</title>
</head>
<body>
    <div id="container" style="width:400px; height:400px"></div>
   <!-- // <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=b5f527860c5aaed7a4fa280e8d39f1e3"></script> -->
       <script src="http://api.map.baidu.com/api?v=2.0&ak=qWmCfqDAdPBzy3YoHxGnimKT"></script>
    <script>

    var map = new BMap.Map("container");
    map.centerAndZoom(new BMap.Point({$longitude},{$latitude}),11);
    map.enableScrollWheelZoom(true);
    
        // var map = new BMap.Map('container', {
        //     zoom : 18,
        //     center : [{$longitude},{$latitude}]
        // });
        // var maker = new BMap.Marker({
        //     position : [{$longitude},{$latitude}],
        //     map : map
        // });

        // 百度地图API功能
    // var map = new BMap.Map("allmap");
    // map.centerAndZoom(new BMap.Point({$longitude},{$latitude}),11);
    // map.enableScrollWheelZoom(true);
    
    // 用经纬度设置地图中心点

            // map.clearOverlays(); 
            // var new_point = new BMap.Point({$longitude}e,{$latitude});
            // var marker = new BMap.Marker(new_point);  // 创建标注
            // map.addOverlay(marker);              // 将标注添加到地图中
            // map.panTo(new_point);      
            map.clearOverlays(); 
            var new_point = new BMap.Point({$longitude},{$latitude});
            var marker = new BMap.Marker(new_point);  // 创建标注
            map.addOverlay(marker);              // 将标注添加到地图中
            map.panTo(new_point);
    
    </script>
</body>
</html>