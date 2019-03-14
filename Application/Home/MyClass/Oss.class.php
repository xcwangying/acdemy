<?php
/*
 *阿里云Oss操作类
 *引入autoloader.php
*/
namespace Home\MyClass;
use OSS\OssClient;
use OSS\Core\OssException;
class Oss{
	/*oss配置*/
	private  $accessKeyId;
	private  $accessKeySecret;
	private  $endpoint;//oss域名
	private  $bucket;
	private  $timeout;
	private  $connectTimeout;

	/*oss客户端实例化对象*/
	private  $ossClient;

	public function __construct($accessKeyId,$accessKeySecret,$endpoint,$bucket,$timeout='3600',$connectTimeout='10'){	
		$this->accessKeyId      = $accessKeyId;
		$this->accessKeySecret  = $accessKeySecret;
		$this->endpoint         = $endpoint;
		$this->bucket           = $bucket;
		$this->timeout          = $timeout;
		$this->connectTimeout   = $connectTimeout;

		$this->ossClient = new OssClient($this->accessKeyId, $this->accessKeySecret, $this->endpoint);
		$this->ossClient->setTimeout($this->timeout/* seconds */);
		$this->ossClient->setConnectTimeout($this->connectTimeout /* seconds */);
	}


	/**
	 * 上传指定的本地文件内容
	 *
	 * @param  string $object   OSS上传路径
	 * @param  string $filePath 本地文件地址
	 * @param  int 	  $del 是否删除本地服务器文件：0不删除1删除
	 * @return string 上传成功返回文件Oss访问地址
	 */
	public function upload($object,$filePath,$del='0'){    	
	    try{
	        $this->ossClient->uploadFile($this->bucket, $object, $filePath);
	        if($del == 1)  unlink($filePath);
	        
	        return $this->getUrl($object);
	    } catch(OssException $e) {

	        return "FAILED:".$e->getMessage();
	    }

	}

	/**
	 * 删除object
	 * @param string $object 文件oss地址 bucket/文件名
	 * @return null
	 * 
	 */
	public function del($object){
		try{
		       $this->ossClient->deleteObject($this->bucket, $object);
		   } catch(OssException $e) {

			    return "FAILED:".$e->getMessage();
		   }

	}

	/*
	 *文件下载
	*/

	/*
	 * 文件上传成功时获取文件Oss url
	 *
	 * @param string $object oss上文件保存路径
	 * @return string 文件在oss上访问域名
	 *
	 */
	private function getUrl($object){

		return 'http://'.$this->bucket.'.'.$this->endpoint.'/'.$object;

	}

	/*
	 *新建存储空间bucket
	*/
	public function createBucket(){



	}
	/**
	 *  判断Bucket是否存在
	 *
	 * @param OssClient $ossClient OssClient实例
	 * @param string $bucket 存储空间名称
	 */
	public function doesBucketExist(){


	}





}
