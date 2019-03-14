<?php
/**
 * Created by PhpStorm.
 * User: cheng
 * Date: 2018/4/10
 * Time: 下午5:55
 */
namespace OSS;

use OSS\OssClient;

class FileClient
{

    const LFIT = "lfit";
    const MFIT = "mfit";
    const FILL = "fill";  // 居中裁剪
    const PAD = "pad";  // 填充白色背景
    const FIXED = "fixed";

    private $config = array();

    private $OssClient = null;

    //原始图片
    private $original = null;

    private $mode = null;

    private $bucket_name = null;

    private $is_base64 = false;


    public function __construct($file)
    {
        //初始化配置
        $this->initConfig();
        $this->config['file'] = $file;
        $accessKeyId = C('ACCESS_KEY_ID');
        $accessKeySecret = C('ACCESS_KEY_SECRET');
        $endpoint = C('ENDPOINT');
        $this->bucket_name = C('BUCKET_NAME');

        if (!is_array($file)) {
            $this->is_base64 = true;
            $this->config['file'] = $file_path = $this->base64_image_content($file, 'oss_tmp');
        }

        $this->OssClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);
    }

    private function base64_image_content($base64_image_content, $path)
    {
        //匹配出图片的格式
        if (preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64_image_content, $result)) {
            $type = $result[2];
            //$new_file = $path."/".date('Ymd',time())."/";
            $new_file = $path . "/";

            if (!file_exists($new_file)) {
                //检查是否有该文件夹，如果没有就创建，并给予最高权限
                mkdir($new_file, 0777);
            }
            $new_file = $new_file . uniqid() . ".{$type}";

            if (file_put_contents($new_file, base64_decode(str_replace($result[1], '', $base64_image_content)))) {
                //return '/'.$new_file;
                return array(
                    "tmp_name" => './' . $new_file,
                    "name" => 'image.' . pathinfo($new_file)['extension']
                );
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public function __set($name, $value)
    {

        if (isset($this->config[$name])) {
            $this->config[$name] = $value;
        } else {

        }
    }

    private function initConfig()
    {
        $this->config = array(
            'width' => 0,
            'height' => 0,
            'file' => '',
        );
        $this->mode = self::LFIT;
    }

    public function mode($mode = self::LFIT)
    {
        $this->mode = $mode;
        return $this;
    }

    public function file($file = '')
    {
        if ($file !== '') {
            $this->config['file'] = $file;
        }

        return $this;
    }

    public function width($width = 0)
    {

        $this->config['width'] = $width;

        return $this;
    }

    public function height($height = 0)
    {
        $this->config['height'] = $height;
        return $this;
    }

    //验证图片 尺寸
    public function checkSize($option)
    {
        $w = $option['w'];
        $h = $option['h'];
        $file = $this->config['file'];

        list($width, $height, $type, $attr) = getimagesize($file['tmp_name']);

        if (count($option) == 2 && $w && $h) {

            if (!is_array($w) && $width != $w) {
                return false;
            }

            if (is_array($w) && ($width < $w[0] || $width > $w[1])) {
                return false;
            }

            if (!is_array($h) == 1 && $height != $h) {
                return false;
            }

            if (is_array($h) && ($height < $h[0] || $height > $h[1])) {
                return false;
            }

            return true;
        }
        return false;
    }

    public function model($mode = self::LFIT)
    {
        $this->mode = $mode;
    }

    public function save($dir = '')
    {



        $OssClient = $this->OssClient;
        $bucketName = $this->bucket_name;
        $file = $this->config['file'];
        //上传的图片不存在

        if ($this->config['file'] == '' && $this->original == '') {
            return false;
        }

        //原始图片没有上传则上传
        if ($this->original == null) {

            $object = $dir . uniqid() . "." . pathinfo($file['name'])['extension'];

            //上传原图
            try {
                $this->OssClient->uploadFile($bucketName, $object, $file['tmp_name']);
            } catch (OssException $e) {
                return false;
            }

            $this->original = $object;

        }

        if ($this->config['width'] != 0 || $this->config['height'] != 0) {



            if($file){
                $newObject = $dir . uniqid() . "." . pathinfo($file['name'])['extension'];
            }else{
                $newObject = $dir . uniqid() . "." . pathinfo($this->original)['extension'];
            }

            $style = "image/resize,m_{$this->mode}";

            if ($this->config['width'] != 0) {
                $style .= ",w_{$this->config['width']}";
            }
            if ($this->config['height'] != 0) {
                $style .= ",h_{$this->config['height']}";
            }

            $options = array(
                $OssClient::OSS_PROCESS => $style,);
            try {
                //获取处理好的图片
                $content = $OssClient->getObject($bucketName, $this->original, $options);
                //缩略
                $OssClient->putObject($bucketName, $newObject, $content);
            } catch (OssException $e) {
                return false;
            }

            $this->initConfig();
            return $newObject;

        } else if($this->config['width'] == 0 || $this->config['height'] == 0){
            $this->initConfig();
            return $this->original;
        }

        return false;
    }

    function __destruct()
    {
        if ($this->is_base64) {
            if ($this->config['file']) {
                unlink($this->config['file']['tmp_name']);
            }

        }
    }

}