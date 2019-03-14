<?php
class UploadFileB{
	/*
	*
	*	上传图片到阿里云
	*	@	$file_name        文件名称  如1.jpg 
	* 	@	$file_full_path   文件的完整路径含文件名称 xx/1.jpg 或者 xx
	*/
	public static function upload_file($file_name,$file_full_path){
		//调用common文件,文件内部:调用自动加载函数,现在class文件的自动加载

		//初始化信息
		UploadFileB::get_config();

		//修改文件目录结构,都使用单一的文件结构
		//实例化bucket,实现文件上传方法
		$bucket = Common::getBucketName();

		//创建ossClient实例
		$ossClient = Common::getOssClient();
		if (is_null($ossClient)) exit(1);
		// 上传本地文件
		$file_full = str_replace('\\',DIRECTORY_SEPARATOR,trim($file_full_path,DIRECTORY_SEPARATOR));

		$yy = is_file($file_full);
		if(is_file($file_full)){
			$re = $ossClient->uploadFile($bucket,$file_name,$file_full);
			return $re;
		}else if(is_dir($file_full) && is_file($file_full.DIRECTORY_SEPARATOR.$file_name)){
			$re = $ossClient->uploadFile($bucket,$file_name,$file_full.DIRECTORY_SEPARATOR.$file_name);
			return $re;
		}else{
			exit(2);//图片错误
		}
	}



	/**
 * 删除object
 *
 * @param OssClient $ossClient OSSClient实例
 * @param string $bucket bucket名字
 * @return null
 */
function delete_file($object)
{	
	//调用common文件,文件内部:调用自动加载函数,现在class文件的自动加载

	//初始化信息
	UploadFileB::get_config();

	//修改文件目录结构,都使用单一的文件结构
	//实例化bucket,实现文件上传方法
	$bucket = Common::getBucketName();

	//创建ossClient实例
	$ossClient = Common::getOssClient();
	if (is_null($ossClient)) exit(1);
   	$res = $ossClient->deleteObject($bucket, $object);
   	if($res==null){ 
   		return true;
   	}else{ 
   		return false;
   	}
   
    	

}


/**
 * 批量删除object
 *
 * @param OssClient $ossClient OSSClient实例
 * @param string $bucket bucket名字
 * @return null
 */
function deleteObjects($objects)
{
    //调用common文件,文件内部:调用自动加载函数,现在class文件的自动加载

	//初始化信息
	UploadFileB::get_config();

	//修改文件目录结构,都使用单一的文件结构
	//实例化bucket,实现文件上传方法
	$bucket = Common::getBucketName();

	//创建ossClient实例
	$ossClient = Common::getOssClient();
	if (is_null($ossClient)) exit(false);
    $res =    $ossClient->deleteObjects($bucket, $objects);
    if($res==null){ 
   		return true;
   	}else{ 
   		return false;
   	}
}

 

/**
 * 判断object是否存在
 *
 * @param OssClient $ossClient OSSClient实例
 * @param string $bucket bucket名字
 * @return null
 */
function doesObjectExist($object)
{
    UploadFileB::get_config();

	//修改文件目录结构,都使用单一的文件结构
	//实例化bucket,实现文件上传方法
	$bucket = Common::getBucketName();

	//创建ossClient实例
	$ossClient = Common::getOssClient();
    try{
        $exist = $ossClient->doesObjectExist($bucket, $object);
    } catch(OssException $e) {
        printf(__FUNCTION__ . ": FAILED\n");
        printf($e->getMessage() . "\n");
        return;
    }
    print(__FUNCTION__ . ": OK" . "\n");
    var_dump($exist);
}



	private static function get_config(){
		//导入自动加载文件
		Vendor('OSS.autoload');
		//导入配置文件
		Vendor('OSS.Config');
		//导入Common类文件,用来实例化
		Vendor('OSS.Common');
	}
}