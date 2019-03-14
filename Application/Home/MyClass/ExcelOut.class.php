<?php
namespace User\MyClass;
use Think\Controller;
//引入PHPExcel库文件（路径根据自己情况）
include "ThinkPHP/Library/Org/Util/PHPExcel/Classes/PHPExcel.php";
include "ThinkPHP/Library/Org/Util/PHPExcel/Classes/PHPExcel/IOFactory.php";
class ExcelOut{

	//定义构造方法
	function connect($server,$username,$password,$dbname){
			//1、连接数据库
		  mysql_connect($server,$username,$password);
		  //2、选择数据库
		  mysql_select_db($dbname);
	}

	//excel表格导入导出支持104列
	//$arr1表头一维索引数组必填
	//$arr2表格内容select查询的数组必填
	//$str文件名称选填
	function outExcel($arr1,$arr2,$str,$str1){
		header("Content-Type:text/html;charset=utf-8");
		//创建对象
	$excel = new PHPExcel();
$arr = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
//获得列长度
$num = count($arr1);
//Excel表格式,这里简略写了8列
for($i=0;$i<$num;$i++){
    if($i<26){
        $letter[] = $arr[$i];
    }elseif(26<=$i&&$i<52){
        $a = $i-26;
        $letter[] = "A".$arr[$a];
    }elseif(52<=$i&&$i<78){
        $b = $i-52;
        $letter[] = "B".$arr[$b];
    }elseif(78<=$i&&$i<104){
        $c = $i-78;
        $letter[] = "C".$arr[$c];
    }
}

//表头数组

$tableheader = $arr1;

//填充表头信息

for($i = 0;$i < count($tableheader);$i++) {

$excel->getActiveSheet()->setCellValue("$letter[$i]1","$tableheader[$i]");
$excel->getActiveSheet()->getColumnDimension("$letter[$i]")->setWidth(20);

}
//表格数组
foreach ($arr2 as $k => $v) {
    foreach ($v as $key => $val) {
        $data[$k][]=$val;
    }
}
//填充表格信息
$n = 2;
for ($i = 2;$i <= count($data) + 1;$i++) {

$j = 0;
$n++;
foreach ($data[$i - 2] as $key=>$value) {

$excel->getActiveSheet()->setCellValueExplicit("$letter[$j]$i","$value",PHPExcel_Cell_DataType::TYPE_STRING);

$j++;

}

}
$n++;
$excel->getActiveSheet()->setCellValueExplicit("$letter[0]$n","合计金额:",PHPExcel_Cell_DataType::TYPE_STRING);
$excel->getActiveSheet()->setCellValueExplicit("$letter[1]$n",$str1,PHPExcel_Cell_DataType::TYPE_STRING);
//创建Excel输入对象
if($str==""){
$str = date("Y-m-d",time());
}
$str = $str.".xls";
$write = new PHPExcel_Writer_Excel5($excel);
header("Pragma: public");

header("Expires: 0");

header("Cache-Control:must-revalidate, post-check=0, pre-check=0");

header("Content-Type:application/force-download");

header("Content-Type:application/vnd.ms-execl");

header("Content-Type:application/octet-stream");

header("Content-Type:application/download");;

header("Content-Disposition:attachment;filename=$str");

header("Content-Transfer-Encoding:binary");

$write->save('php://output');
	}
	//Excel导入类支持05版和07版EXCEL
	//$dir上传后文件所在文件夹（Upload子目录）字符串
	//$title一维关联数组execl行名=>字段名。例：$arr = array("公司名称"=>"e_name","公司编码"=>"e_code" );
	//$table字符串 表全称
	//$did添加字段, 一维索引数组，第一个值为字段名，第二个值为固定参数。可选；例：array("字段，字段，字段"，"值，值，值")。
	//返回一维索引数组下标0为总共多少记录，下标1为成功多少记录
	//失败返回false

	 function inExcel($table,$title,$did=false,$dir="tmp"){
		header("Content-Type:text/html;charset=utf-8");
			foreach ($_FILES as $key => $v) {
			  $filename = $v['name'];
			  $filetmp = $v['tmp_name'];
			}
		    //自己设置的上传文件存放路径
		    $dirstr = strrpos($dir,'/')==false?"/":"";
		    $filePath = "./Uploads/".$dir.$dirstr;
		    $str = "";  
		    //下面的路径按照你PHPExcel的路径来修改
		    //"home/Extend/Library/ORG/Util/PHPExcel/Classes/PHPExcel.php";
		    include 'home/Extend/Library/ORG/Util/PHPExcel/Classes/PHPExcel.php';
		    include 'home/Extend/Library/ORG/Util/PHPExcel/Classes/PHPExcel/IOFactory.php';


		    //注意设置时区
		    $time=date("Ymdhmi");//去当前上传的时间
		    //获取上传文件的扩展名
		    $extend=substr($filename,strrpos($filename,'.')+1);
		    if($extend=="xls"){
			    include 'home/Extend/Library/ORG/Util/PHPExcel/Classes/PHPExcel/Reader/Excel5.php';
			    $objReader = PHPExcel_IOFactory::createReader('Excel5');
		    }else if($extend=="xlsx"){
			    include 'home/Extend/Library/ORG/Util/PHPExcel/Classes/PHPExcel/Reader/Excel2007.php';
			    $objReader = PHPExcel_IOFactory::createReader('Excel2007');
		    }else{
		      return "未知文件格式";
		    }
		    //上传后的文件名
		    $name=$time.".".$extend;
		    $uploadfile=$filePath.$name;//上传后的文件名地址
		    if(!file_exists($filePath)){
		    	mkdir($filePath);
		  	}
		    //move_uploaded_file() 函数将上传的文件移动到新位置。若成功，则返回 true，否则返回 false。
		    $result=move_uploaded_file($filetmp,$uploadfile);//假如上传到当前目录下
		    //echo $result;
		   if($result) //如果上传文件成功，就执行导入excel操作
		    { $sql = "";
		        $objPHPExcel = $objReader->load($uploadfile);
		        $sheet = $objPHPExcel->getSheet(0);
		        $highestRow = $sheet->getHighestRow();           //取得总行数
		        $highestColumn = $sheet->getHighestColumn(); //取得总列数

		        $objWorksheet = $objPHPExcel->getActiveSheet();
		        $highestRow = $objWorksheet->getHighestRow();//总行数
		        $highestColumn = $objWorksheet->getHighestColumn();
		        $highestColumnIndex = PHPExcel_Cell::columnIndexFromString($highestColumn);//总列数
		        $headtitle=array();
		        $sql .= "INSERT INTO {$table}(";
		        for ($row = 1;$row <= 1;$row++)
		        {
		            $strs=array();
		            //注意highestColumnIndex的列数索引从0开始
		            for ($col = 0;$col < $highestColumnIndex;$col++)
		            {
		               foreach ($title as $k => $v) {
		                  if($k == $objWorksheet->getCellByColumnAndRow($col, $row)->getValue()){
		                    $sql .= "".$v.",";
		                    $num[$k] = $col;
		                  }
		               }
		            }   
		           
		        }
		    $strend = substr_replace($sql,"",strlen($sql)-1,1);
		    if($did){
		    $sql = $strend.",".$did[0].") VALUES (";
		    }else{
		          $sql = $strend.") VALUES (";
		    }

		    $znum = 0;
		        for ($row = 2;$row <= $highestRow;$row++)
		        {
		            $strs=array();
		              foreach ($title as $k => $v) {
		                  
		                  foreach ($num as $key => $val) {
		                    if($k == $key){
		                    $sql .= "'".$objWorksheet->getCellByColumnAndRow($val, $row)->getValue()."',";
		                    }
		                  }
		               }
		              $strend = substr_replace($sql,"",strlen($sql)-1,1);
		              if($did){
		                $sql = $strend.",".$did[1]."),(";
		              }else{
		              $sql = $strend."),(";
		              }

		            $znum++;
		        }
		    $strend = substr_replace($sql,"",strlen($sql)-3,3);
		    $sql = $strend.");";
		  
		  //连接数据库
		  // $this->connect("localhost","root","root","leaveword");
		  // $result = mysql_query($sql);
	      $result = M($table)->execute($sql);
	        if($result){
	          $arrout[] = $znum;
	          $arrout[] = $result;
	          //$arrout[] =  mysql_affected_rows();
	          unlink($uploadfile);
	          return $arrout;
	        }
	    }else{
	    	unlink($uploadfile);
	       return false;
	    }
	}     
}
?>