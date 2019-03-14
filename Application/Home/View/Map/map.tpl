<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>指定地理坐标定位</title>
<style type="text/css">

#container{
  min-width:600px;
  min-height:767px;
  }
</style>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
    <script src="__Assert__/js/jquery.min.js"></script>
<script>



$(function(){ 
    var map,marker = null; 
    var center = new qq.maps.LatLng({$latitude},{$longitude});
    // var city = document.getElementById("city");
    map = new qq.maps.Map(document.getElementById('container'),{
        center: center,
        zoom: 13
    });
     var marker = new qq.maps.Marker({
        position: center,
        map: map
    });
    // //调用城市服务信息
    // var citylocation = new qq.maps.CityService({
    //     complete : function(results){
    //         alert(results);
    //         map.setCenter(results.detail.latLng);
    //         // city.style.display = 'inline';
    //         // city.innerHTML = '所在位置: ' + results.detail.name;
            
    //         if (marker != null) {
    //             marker.setMap(null);
    //         }
    //         //设置marker标记
    //         marker = new qq.maps.Marker({
    //             map: map,
    //             position: results.detail.latLng
    //         });
    //     }
    // });
    //  //解析成浮点数 取值第一位 第二位
    // var lat = {$longitude};
    // var lng = {$latitude};
  
    // //设置经纬度信息
    // var latLng = new qq.maps.LatLng(lat, lng);
    // //调用城市经纬度查询接口实现经纬查询
    // citylocation.searchCityByLatLng(latLng);

   
})
</script>
</head>
<body >


<div id="container"></div>

</body>
</html>
