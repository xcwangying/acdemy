<?php
ini_set( 'display_errors', 'On' );
require_once 'autoload.php';
use OSS\OssClient;
use OSS\Core\OssException;
$accessKeyId = "LTAIJjRm5VXw7vot";
$accessKeySecret = "OTD0e2Oolj5UEuXE4pDV8Xz7fNdHjj";
$endpoint = "honper.oss-cn-beijing-internal.aliyuncs.com";
try {
    $ossClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);
} catch (OssException $e) {
    print $e->getMessage();
}
