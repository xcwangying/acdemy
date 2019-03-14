<?php
namespace Org\Net;
//分销类及退货处理类
//分销入口方法 handle($orid,$type)//$orid订单id,$type支付方式
//退款入口方法 return_goods($orid) //$orid订单id
//方法总计 9个方法 下面为每个方法的作用
//
////会员购买身份统计表记录setSingle
	//$vid购买人的id
	//$type状态1购买，2退货
	//$identity,退货时会员变化的身份
	//public function setSingle($vid,$type,$identity)
	//
	/*//会员下线统计表的统计、
	//$oldidentity购买前的身份
	//$type状态1购买，2退货
	//$identity,退货时会员变化的身份
	public function setOffline($oldidentity,$type,$identity)

	//查询当前会员是否还是钻石合伙人
	$vid查询人的id
	public function setDiamonds($vid)

	//会员升级记录
	//$oldidentity购买前的身份
	//$vid购买人的id
	//$type 1为购买，2为退货
	public function setVip_fu($oldidentity,$vid,$type)

	//三级的积分变化
	//$one,第一级的id
	//$two,第二级的id
	//$three,第三级的id
	//$orderinfo,订单的信息
	//$type 1是购买 2是退货
	public function threeIdentity($one,$two,$three,$orderinfo,$type)
	
	//钻石合伙人的分成
	//$orderinfo订单的信息
	//$type 1 购买 2退货
	public function diamonds_Identity($orderinfo,$type)

	//查询上级信息
	//上级会员的邀请码$ikey
	//成功返回true并存入上三级信息 
	//失败返回false
	public function superior($ikey)

	//查询钻石合伙人的信息
	上级会员的邀请码$ikey
	public function diamonds_superior($ikey)

	//积分月汇总表的数据
	//$vid 会员的id
	//$credit 三级奖励
	//$bcredit 钻石奖励
	//$type 1购买 2 退货
	public function month_sum($vid,$credit,$bcredit,$type)
	*/
class Distribution{
	
	public $order = "";//订单表
	
	public $vip = "";//会员表

	public $vip_fu = '';//会员身份变化表

	public $identity = '';//身份设置表
	
	public $goods = '';//商品表

	public $chieflist = '';//上级分销流水表

	public $serlist = '';//客服分销流水表

	public $platlist = '';//平台分销流水表

	public $integral_chage = '';//积分变化表

	public $month_credit = '';//积分月汇总表

	public $single = '';//会员购买身份的统计表

	public $offline = '';//会员一级下线统计表

	public $vip_relationship = '';//会员三级关系表

	public $orid = '';//订单的id

	public $pid = '';//项目分类的id
	
	public $type = '';//支付方式

	public $identityinfo = '';//对应项目的分销信息

	public $one = '';//第一级信息

	public $two = '';//第二级信息

	public $three = '';//第三级信息

	//设置下一级购买和自己返单哪些身份，加盟商可以升级到钻石合伙人//关联身份表id
	public $diamonds = array(7);

	//设置当前会员为什么身份才可以升级为钻石合伙人//关联身份表id
	public $diamonds_vip = array(7);

	//设置钻石合伙人的三级奖励
	public $diamonds_fen = array(
							"one"=>500,//第一级钻石提成
							"two"=>300,//第二级钻石提成
							"three"=>200,//第三级钻石提成
						);

	//设置成为钻石合伙人累计需要购买单数
	public $diamonds_num = 10;

	//钻石三级信息
	public $diamonds_info = array(
							"one"=>'',//第一级钻石的信息
							"two"=>'',//第二级钻石的信息
							"three"=>'',//第三级钻石的信息
						);

	//购买什么身份钻石才有提成//关联身份表id
	public $diamonds_tc = array(7);

	//构造方法
	public function __construct(){    
		
		$this->order = M("order","ybs_");//订单表
		
		$this->vip = M("vip","ybs_");//会员表

		$this->vip_fu = M("vip_fu","ybs_");//会员身份变化表

		$this->identity = M("identity","ybs_");//身份设置表

		$this->goods = M("goods","ybs_");//商品表

		$this->chieflist = M("chieflist","ybs_");//上级分销流水表

		$this->serlist = M("serlist","ybs_");//客服分销流水表

		$this->platlist = M("platlist","ybs_");//平台分销流水表

		$this->integral_chage = M("integral_chage","ybs_");//积分变化表

		$this->single = M("single","ybs_");//会员购买身份的统计表

		$this->offline = M("offline","ybs_");//会员一级下线统计表

		$this->month_credit = M("month_credit","ybs_"); // 积分月汇总表

		$this->vip_relationship = M("vip_relationship","ybs_");//会员三级关系表
	}
	//购买身份项目的分销
	//传入订单$orid,支付方式$type int 1，微信。 2，pos机。 3，转账
	//处理订单状态及会员身份更改,三级分销,客服提成，平台提成，钻石提成
	//成功返回true；失败返回false；
	public function handle($orid,$type){
		
		$this->orid = $orid;//订单的id
		
		$this->type = $type;//支付方式
		//判断订单id是否传入
		if($this->orid){
			//有订单id
			$omap['order_id'] = $this->orid;//订单id
			$omap['payment_type'] = '0';//支付方式 1，微信。 2，pos机。 3，转账。
			$omap['lock_state'] = "0";//订单状态正常
			$omap['order_state'] = '10';//未付款状态
			$orderinfo = $this->order->where($omap)->find();//查询对应订单id并且未支付的订单

			//判断订单是否存在
			if($orderinfo){//存在订单,修改订单状态变为已支付，
				$gmap['goods_id'] = $orderinfo['goods_id'];
				$goods_identity = $this->goods->where($gmap)->getField("goods_identity");//查询商品对应的身份信息
				
				$this->pid = $this->goods->where($gmap)->getField("pid");//查询商品对应的项目分类
				$imap['id'] = $goods_identity;//身份的id
				$this->identityinfo = $this->identity->where($imap)->find();//订单对应的设置信息包括分销
				if($this->identityinfo['id'] != '3'){
					//平台的分成
					$this->plat = array($this->identityinfo['id']=>$orderinfo['order_amount']*0.05);//除了购买课程其他固定5%的分成
				}else{
					$this->plat = array('3'=>1.9);//平台固定1.9元
				}
				
				$odata['payment_type'] = $this->type;//支付方式
				$odata['payment_time'] = time();//支付时间
				$odata['order_state'] = '20';//订单状态，20已付款
				if($type == '3'){
					$odata['actual_money'] = $orderinfo['order_amount'];//实际支付金额
				}else{
					$odata['actual_money'] = $orderinfo['order_amount']-$orderinfo['order_amount']*0.005;//实际支付金额,通联扣除千5手续费
				}
				
				M()->startTrans();//开启事物
				$this->goods->where($gmap)->setInc("goods_pay",1);//增加商品的购买人数
				$this->goods->where($gmap)->setInc("goods_order",1);//增加商品的下单人数

        		$ordes = $this->order->where($omap)->save($odata);//改变订单状态

        		$vmap['vid'] = $orderinfo['buyer_id'];//会员的id

        		$oldvip = $this->vip->where($vmap)->find();//查询会员信息

        		//查询当前会员上三级//调用方法
        		$this->superior($oldvip['ikey'],'1');
        		
        		//查询当前会员上三级钻石合伙人
        		$this->diamonds_superior($oldvip['ikey'],'1');
        		
        		//会员身份是否变化及记录身份变化//调用方法
        		$oldiden = $this->setVip_fu($oldvip['identity'],$orderinfo['buyer_id'],'1');

	        	//当前会员购买信息的统计,并且查询是否能升级钻石合伙人//调用方法 1购买
	        	$this->setSingle($orderinfo['buyer_id'],'1',$oldiden);

	        	//当前会员上线统计表的统计,并且查询是否能升级钻石合伙人//调用方法
				$this->setOffline($oldvip['identity'],'1',$oldiden);
        		

	        	$vfs = $this->vip->where($vmap)->setInc("use_money",$orderinfo['order_amount']);//修改会员累计消费

        		//判断会员及订单修改是否成功
        		if($vfs && $ordes){
        			
        			//分成开始
        			if($oldvip['identity'] == '7'){//会员身份为加盟商的自己是自己的一级
        				//处理三级的方法
        				$this->threeIdentity($oldvip,$this->one,$this->two,$orderinfo,'1');

        				$this->diamonds_Identity($orderinfo,'1');

        			}else if($this->one){//存在上级的处理
        				//处理三级的方法
        				$this->threeIdentity($this->one,$this->two,$this->three,$orderinfo,'1');
        				$this->diamonds_Identity($orderinfo,'1');
        			}else{//没有上级的处理
        				//处理三级的方法
        				$this->threeIdentity('','','',$orderinfo,'1');
        					
        			}
        			M()->commit();
        			return true;
        		}else{//会员或订单修改失败
        			M()->rollback();
        			return false;exit;
        		}
			}else{//不存在订单
				
				return false;exit;
			}
		}else{//没有订单id
			
			return false;exit;
		}
		
	}

	//处理退货，退积分，退身份，
	public function  return_goods($orid){
		$this->orid = $orid;//订单的id
		//判断订单id是否传入
		if($this->orid){
			//有订单id
			$omap['order_id'] = $this->orid;//订单id
			$omap['order_state'] = array("in","20,30,40,50");//已付款状态20:已付款;30:已发货;40:已收货;50:已完成
			$orderinfo = $this->order->where($omap)->find();//查询对应订单id并且未支付的订单

			//判断订单是否存在
			if($orderinfo){//存在订单,修改订单状态变为已退货，
				$gmap['goods_id'] = $orderinfo['goods_id'];
				$goods_identity = $this->goods->where($gmap)->getField("goods_identity");//查询商品对应的身份信息
				$this->pid = $this->goods->where($gmap)->getField("pid");//查询商品对应的项目分类
				$imap['id'] = $goods_identity;//身份的id
				$this->identityinfo = $this->identity->where($imap)->find();//订单对应的设置信息包括分销
				if($this->identityinfo['id'] != '3'){
					//平台的分成
					$this->plat = array($this->identityinfo['id']=>$orderinfo['order_amount']*0.05);//除了购买课程其他固定5%的分成
				}else{
					$this->plat = array('3'=>1.9);//平台固定1.9元
				}
				
				$odata['order_state'] = '60';//订单状态，20已付款60已取消
				$odata['lock_state'] = '2';//2已退货锁定
				M()->startTrans();//开启事物
				$this->goods->where($gmap)->setDec("goods_pay",1);//减少商品的购买人数

        		$ordes = $this->order->where($omap)->save($odata);//改变订单状态

        		$vmap['vid'] = $orderinfo['buyer_id'];//会员的id

        		$oldvip = $this->vip->where($vmap)->find();//查询会员信息
        		
        		//查询当前会员上三级//调用方法
        		$this->superior($oldvip['ikey'],'2');
				
        		//查询当前会员上三级钻石合伙人
        		$this->diamonds_superior($oldvip['ikey'],'2');
        		//return false;
        		//会员身份是否变化及记录身份变化//调用方法
        		$oldiden = $this->setVip_fu($oldvip['identity'],$orderinfo['buyer_id'],'2');

	        	//当前会员退货信息的统计,并且查询是否能升级钻石合伙人//调用方法2退货
	        	$this->setSingle($orderinfo['buyer_id'],'2',$oldiden);

	        	//当前会员上线统计表的统计,并且查询是否能升级钻石合伙人//调用方法2退货
				$this->setOffline($oldvip['identity'],'2',$oldiden);
        		//return false;

	        	$vfs = $this->vip->where($vmap)->setDec("use_money",$orderinfo['order_amount']);//修改会员累计消费

        		//判断会员及订单修改是否成功
        		if($vfs && $ordes){//修改积分流水//增加退货流水
    				$this->threeIdentity($this->one,$this->two,$this->three,$orderinfo,'2');
    				//return false;
    				$this->diamonds_Identity($orderinfo,'2');
    				//return false;
        			M()->commit();
        			return true;
        		}else{//会员或订单修改失败
        			M()->rollback();
        			return false;exit;
        		}
			}else{//不存在订单
				
				return false;exit;
			}
		}else{//没有订单id
			
			return false;exit;
		}
	} 
	//会员购买身份统计表记录
	//$vid购买人的id
	//$type状态1购买，2退货
	//$identity,退货时会员变化的身份
	public function setSingle($vid,$type,$identity){
		if($type == '1'){
			$simap['vid'] = $vid;//会员的id
	    	$simap['identity'] = $this->identityinfo['id'];//购买的身份
	    	//会员购买信息的统计
	    	$sires = $this->single->where($simap)->find();
	    	//是否存在记录
	    	if($sires){//存在记录
				$sinres = $this->single->where($simap)->setInc("num",1);//购买数量加一
				if(!$sinres){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    	}else{//不存在记录
	    		$simap['num'] = 1;
	    		$sinres = $this->single->add($simap);//增加购买记录
	    		if(!$sinres){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    	}
		}else if($type == '2' && $identity){
			$simap['vid'] = $vid;//会员的id
	    	$simap['identity'] = $identity;//购买的身份
	    	//会员购买信息的统计
	    	$sires = $this->single->where($simap)->find();
	    	//是否存在记录
	    	if($sires && ($identity == $this->identityinfo['id'])){
	    		$odmap['vid'] = $vid;//会员的id
	    		$odmap['identity'] = $this->identityinfo['id'];//购买的身份
	    		$odres = $this->single->where($odmap)->setDec("num",1);//之前购买数量减一
				if(!$odres){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    	}else if($sires){//存在记录
	    		$odmap['vid'] = $vid;//会员的id
	    		$odmap['identity'] = $this->identityinfo['id'];//购买的身份
	    		$odres = $this->single->where($odmap)->setDec("num",1);//之前购买数量减一
				$sinres = $this->single->where($simap)->setInc("num",1);//购买数量加一
				if(!$sinres || !$odres){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    	}else{//不存在记录
	    		$simap['num'] = 1;
	    		$sinres = $this->single->add($simap);//增加购买记录
	    		if(!$sinres){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    	}
		}else{
			return true;
		}
		
    	//判断当前会员是否能升级为钻石合伙人//调用方法
    	return $this->setDiamonds($vid);
    	 //true;
	}
	//会员下线统计表的统计、
	//$oldidentity购买前的身份
	//$type状态1购买，2退货
	//$identity,退货时会员变化的身份
	public function setOffline($oldidentity,$type,$identity){
		if(($type == '1') && ($this->identityinfo['id'] > $oldidentity) && $this->one['vid']){
			$ofmap['vid'] = $this->one['vid'];//上级会员的id
        	$ofmap['identity'] = $oldidentity;//购买人以前的身份
        	//会员购买信息的统计
        	$ofres = $this->offline->where($ofmap)->find();

        	//是否存在记录
        	if($ofres){//存在记录
				$num_res = $this->offline->where($ofmap)->setDec("num",1);//更新旧身份购买人数量减一
				if(!$num_res){
        			M()->rollback();
        			return false;exit;
        		}
        	}
        	$ofmap['identity'] = $this->identityinfo['id'];//购买的身份
        	$lineres = $this->offline->where($ofmap)->find();

			if($lineres){
				$line = $this->offline->where($ofmap)->setDec("num",1);//更新新身份购买人数量加一
				if(!$line){
        			M()->rollback();
        			return false;exit;
        		}
			}else{
				$ofmap['num'] = 1;
				$line = $this->offline->add($ofmap);//增加购买人记录
				if(!$line){
        			M()->rollback();
        			return false;exit;
        		}
			}
		}else if(($type == '2') && ($identity != $this->identityinfo['id']) && $this->one['vid']){//退货
			$ofmap['vid'] = $this->one['vid'];//上级会员的id
        	$ofmap['identity'] = $this->identityinfo['id'];//购买人以前的身份
        	//会员购买信息的统计
        	$ofres = $this->offline->where($ofmap)->find();
        	//是否存在记录
        	if($ofres){//存在记录
				$num_res = $this->offline->where($ofmap)->setDec("num",1);//更新旧身份购买人数量减一
				if(!$num_res){
        			M()->rollback();
        			return false;exit;
        		}
        	}
        	$ofmap['identity'] = $identity;//购买的身份
        	$lineres = $this->offline->where($ofmap)->find();
			if($lineres){
				$line = $this->offline->where($ofmap)->setDec("num",1);//更新新身份购买人数量加一
				if(!$line){
        			M()->rollback();
        			return false;exit;
        		}
			}else{
				$ofmap['num'] = 1;
				$line = $this->offline->add($ofmap);//增加购买人记录
				if(!$line){
        			M()->rollback();
        			return false;exit;
        		}
			}
		}
		//判断当前会员是否能升级为钻石合伙人//调用方法
    	$this->setDiamonds($this->one['vid']);
	}
	//查询当前会员是否还是钻石合伙人
	//$vid 查询人的id
	public function setDiamonds($vid){
		$map['vid'] = $vid;
		$map['identity'] = array("in",$this->diamonds);
		$sincout = $this->single->where($map)->sum("num");//查询当前会员购买了几次可以升级的单
		$offcout = $this->offline->where($map)->sum("num");//查询当前会员下一级购买了几次可以升级的单
		$dicount = $sincout+$offcout;
		$vmap['vid'] = $vid;//会员的id
		$diamonds = $this->vip->where($vmap)->getField("diamonds");
		if(($dicount >= $this->diamonds_num) && ($diamonds != '1')){//达到升级条件
			$vfs = $this->vip->where($vmap)->setField("diamonds","1");//会员升级为钻石合伙人
		}else if(($dicount < $this->diamonds_num) && ($diamonds == '1')){
			$vfs = $this->vip->where($vmap)->setField("diamonds","0");//会员由钻石合伙人降级
		}else{
			$vfs = true;
		}
		if(!$vfs){
			M()->rollback();
			return false;exit;
		}else{
			return true;
		}
	}
	//会员升级记录
	//$oldidentity购买前的身份
	//$vid购买人的id
	//$type 1为购买，2为退货
	public function setVip_fu($oldidentity,$vid,$type){

		if(($this->identityinfo['id'] > $oldidentity) && ($type=='1')){//判断是否变更会员身份
			//购买身份大于当前身份，改变会员身份
			//查询身份附属表是否有当天数据，有修改，没有新增
			$vfmap['vid'] = $vid;//会员的id
			$stime = strtotime(date("Y-m-d",time()));//当天开始时间
			$etime = $stime +3600*24;//当天结束时间
			$vfmap['time'] = array("BETWEEN","{$stime},{$etime}");
			$vfmap['type'] = '0';//购买
			$vres = $this->vip_fu->where($vfmap)->find();
			if($vres){//有修改
				$vfres = $this->vip_fu->where($vfmap)->setField("iid",$this->identityinfo['id']);
			}else{//没有新增
				//会员附属表信息
	    		$vdata['identity'] = $this->identityinfo['id'];//购买的身份的id
	    		$vfdata['vid'] = $vid;//会员的id
	    		$vfdata['orid'] = $this->orid;//订单的id
	    		$vfdata['iid'] = $this->identityinfo['id'];//购买后的身份
	    		$vfdata['time'] = time();//变化的时间
	    		$vfdata['oid'] = $oldidentity;//购买前的身份
	    		$vfres = $this->vip_fu->add($vfdata);//添加会员身份变化记录
			}
			
    		$vmap['vid'] = $vid;
    		$vip = $this->vip->where($vmap)->setField("identity",$this->identityinfo['id']);//改变会员身份
    		if(!$vfres || !$vip){
    			M()->rollback();
    			return false;exit;
    		}else{
    			return $oldidentity;
    		}
		}elseif(($this->identityinfo['id'] >= $oldidentity) && ($type=='2')){//判断是否变更会员身份
			$map['buyer_id'] = $vid;//会员的id
			$map['lock_state'] = '0';//正常
			$map['order_state'] = array("in",'20,30,40,50');//已支付
			$order = $this->order->where($map)->order("goods_ecommend desc")->getField("goods_ecommend");//查询会员购买的最大身份
			if($order >= $this->identityinfo['id']){//会员购买的最大身份大于或等于当前退货身份，则不修改会员身份
				return $order;//不用改变会员身份
			}else{//会员购买的最大身份小于当前退货身份，则修改会员身份为会员购买的最大身份
				if(!$order){
					$order = '2';//没有订单时身份变为用户
				}
				//购买身份大于当前身份，改变会员身份
				//查询身份附属表是否有当天数据，有修改，没有新增
				$vfmap['vid'] = $vid;//会员的id
				$stime = strtotime(date("Y-m-d",time()));//当天开始时间
				$etime = $stime +3600*24;//当天结束时间
				$vfmap['time'] = array("BETWEEN","{$stime},{$etime}");
				$vfmap['type'] = '1';//购买
				$vres = $this->vip_fu->where($vfmap)->find();
				if($vres){//有修改
					$vfres = $this->vip_fu->where($vfmap)->setField("iid",$order);
				}else{//没有新增
					//会员附属表信息
		    		$vdata['identity'] = $order;//购买的身份的id
		    		$vfdata['vid'] = $vid;//会员的id
		    		$vfdata['orid'] = $this->orid;//订单的id
		    		$vfdata['iid'] = $order;//购买后的身份
		    		$vfdata['time'] = time();//变化的时间
		    		$vfdata['oid'] = $this->identityinfo['id'];//购买前的身份
		    		$vfdata['type'] = '1';//退货变化身份
		    		$vfres = $this->vip_fu->add($vfdata);//添加会员身份变化记录
				}
				
	    		$vmap['vid'] = $vid;
	    		$vip = $this->vip->where($vmap)->setField("identity",$order);//改变会员身份
	    		if(!$vfres && !$vip){
	    			M()->rollback();
	    			return false;exit;
	    		}else{//返回更新后的身份
	    			return $order;
	    		}
			}
		}else{//不用改变会员身份
			return false;
		}
	}
	//三级的积分变化
	//$one,第一级的id
	//$two,第二级的id
	//$three,第三级的id
	//$orderinfo,订单的信息
	//$type 1是购买 2是退货
	public function threeIdentity($one,$two,$three,$orderinfo,$type){
		if($type == '1'){
			//客服是否有分成
			if($this->identityinfo['platform'] > 0){//客服有分成
				$sedata['orid'] = $orderinfo['order_id'];//订单的id
				$sedata['pid'] = $this->pid;//项目分类的id
				$sedata['cid'] = $orderinfo['buyer_id'];//购买人的id
				$sedata['uid'] = $this->vip->where("vid=".$orderinfo['buyer_id'])->getField('suid');//客服的id
				$sedata['money'] = $this->identityinfo['platform'];//客服分成的金额
				$sedata['time'] = time();//时间
				$res = $this->serlist->add($sedata);//添加客服分成记录
				if(!$res){
	    			M()->rollback();
	    			return false;exit;
	    		}
			}
			//平台是否有分成
			if($this->plat[$this->identityinfo['id']] > 0){//平台有分成
				$pldata['orid'] = $orderinfo['order_id'];//订单的id
				$pldata['pid'] = $orderinfo['order_id'];//项目分类的id
				$pldata['cid'] = $orderinfo['buyer_id'];//购买人的id
				$pldata['pid'] = $this->pid;//项目分类的id
				$pldata['money'] = $this->plat[$this->identityinfo['id']];//平台分成的金额
				$pldata['time'] = time();//时间
				$res = $this->platlist->add($pldata);//添加客服分成记录
				if(!$res){
	    			M()->rollback();
	    			return false;exit;
	    		}
			}
			//return (($this->identityinfo['in_one'] > 0) && $one['vid']);
			//购买对应身份一级是否有分成,并且存在一级
			if(($this->identityinfo['in_one'] > 0) && $one['vid']){//购买对应身份一级有分成
				$cdata['orid'] = $orderinfo['order_id'];//订单的id
				$cdata['pid'] = $this->pid;//项目分类的id
				$cdata['cid'] = $orderinfo['buyer_id'];//购买人的id
				$cdata['omoney'] = $this->identityinfo['in_one'];//一级拿的钱
				$cdata['oid'] = $one['vid'];//一级的id
				//增加一级累计总积分
				$one_in = $this->vip->where("vid=".$one['vid'])->setInc("integral",$this->identityinfo['in_one']);
				//增加一级可用积分
				$one_sin = $this->vip->where("vid=".$one['vid'])->setInc("sintegral",$this->identityinfo['in_one']);
				if(!$one_in || !$one_sin){
	    			M()->rollback();
	    			return false;exit;
	    		}
				//积分变化表需要的数据start
				$icdata_one['ictime'] = time();//时间
				$icdata_one['befor_integral'] = $one['sintegral'];//变化前积分
				$icdata_one['after_integral'] = $one['sintegral']+$this->identityinfo['in_one'];//变化后积分
				$icdata_one['current_integral'] = $this->identityinfo['in_one'];//变化积分
				$icdata_one['chage_state'] = '1';//1:佣金 2:提现 
				$icdata_one['vid'] = $one['vid'];//变化人的id
				$icdata_one['orid'] = $orderinfo['order_id'];//订单表的id
				$icdata_one['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
				$in_one = $this->integral_chage->add($icdata_one);//积分变化记录end
				if(!$in_one){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    		$this->month_sum($one['vid'],$this->identityinfo['in_one'],'',$type);//积分月汇总
	    	}else{
	    		return true;
	    	}
	    	//购买对应身份二级是否有分成,并且存在二级
	    	if(($this->identityinfo['in_two'] > 0) && $two['vid']){//存在二级
				$cdata['tmoney'] = $this->identityinfo['in_two'];//二级拿的钱
				$cdata['tid'] = $two['vid'];//二级的id
				//增加二级累计总积分
				$two_in = $this->vip->where("vid=".$two['vid'])->setInc("integral",$this->identityinfo['in_two']);
				//增加二级可用积分
				$two_sin = $this->vip->where("vid=".$two['vid'])->setInc("sintegral",$this->identityinfo['in_two']);
				if(!$two_in || !$two_sin){
	    			M()->rollback();
	    			return false;exit;
	    		}
				//积分变化表需要的数据start
				$icdata_two['ictime'] = time();//时间
				$icdata_two['befor_integral'] = $two['sintegral'];//变化前积分
				$icdata_two['after_integral'] = $two['sintegral']+$this->identityinfo['in_two'];//变化后积分
				$icdata_two['current_integral'] = $this->identityinfo['in_two'];//变化积分
				$icdata_two['chage_state'] = '1';//1:佣金 2:提现 
				$icdata_two['vid'] = $two['vid'];//变化人的id
				$icdata_two['orid'] = $orderinfo['order_id'];//订单表的id
				$icdata_two['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
				$in_two = $this->integral_chage->add($icdata_two);//积分变化记录end
				if(!$in_two){
	    			M()->rollback();
	    			return false;exit;
				}
				$this->month_sum($two['vid'],$this->identityinfo['in_two'],'',$type);//积分月汇总
			}
			//购买对应身份三级是否有分成,并且存在三级
			if(($this->identityinfo['in_three'] > 0) && $three['vid']){//存在三级
				$cdata['rmoney'] = $this->identityinfo['in_three'];//三级拿的钱
				$cdata['rid'] = $three['vid'];//三级的id
				//增加三级累计总积分
				$three_in = $this->vip->where("vid=".$three['vid'])->setInc("money",$this->identityinfo['in_three']);
				//增加三级可用积分
				$three_sin = $this->vip->where("vid=".$three['vid'])->setInc("smoney",$this->identityinfo['in_three']);
				if(!$three_in || !$three_sin){
	    			M()->rollback();
	    			return false;exit;
	    		}
				//积分变化表需要的数据start
				$icdata_three['ictime'] = time();//时间
				$icdata_three['befor_integral'] = $three['smoney'];//变化前积分
				$icdata_three['after_integral'] = $three['smoney']+$this->identityinfo['in_three'];//变化后积分
				$icdata_three['current_integral'] = $this->identityinfo['in_three'];//变化积分
				$icdata_three['chage_state'] = '6';//1:佣金 2:提现 ,6第三级的奖励金
				$icdata_three['vid'] = $three['vid'];//变化人的id
				$icdata_three['orid'] = $orderinfo['order_id'];//订单表的id
				$icdata_three['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
				$res = $this->integral_chage->add($icdata_three);//积分变化记录end
				if(!$res){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    		$this->month_sum($three['vid'],'',$this->identityinfo['in_three'],$type);//积分月汇总
			}
			$cdata['time'] = time();//时间
	        $chres = $this->chieflist->add($cdata);//增加三级积分变化记录
	        
	        if($chres){//记录添加成功
	        	return true;
	        }else{
	        	M()->rollback();
	    		return false;exit;
	        }
		}else if($type == '2'){//查询对应订单的记录并且新增退货记录
			$map['orid'] = $orderinfo['order_id'];//订单的id
			$map['type'] = '0';//正常
			$map['sort'] = '0';//三级分的钱
			$chiefdata = $this->chieflist->where($map)->find();//查询数据是否存在
			if(!$chiefdata){//没有上级
	    		return true;
			}else{//添加三级的退货扣减积分前两级为积分，
				//购买对应身份一级是否有分成,并且存在一级
				if(($chiefdata['omoney'] > 0) && $chiefdata['oid']){//购买对应身份一级有分成
					$one_sintegral = $this->vip->where("vid=".$chiefdata['oid'])->getField("sintegral");
					//增加一级累计总积分
					$one_in = $this->vip->where("vid=".$one['vid'])->setDec("integral",$chiefdata['omoney']);
					//增加一级可用积分
					$one_sin = $this->vip->where("vid=".$one['vid'])->setDec("sintegral",$chiefdata['omoney']);
					if(!$one_in || !$one_sin){
		    			M()->rollback();
		    			return false;exit;
		    		}
					//积分变化表需要的数据start
					$icdata_one['ictime'] = time();//时间
					$icdata_one['befor_integral'] = $one_sintegral;//变化前积分
					$icdata_one['after_integral'] = $one_sintegral-$chiefdata['omoney'];//变化后积分
					$icdata_one['current_integral'] = $chiefdata['omoney'];//变化积分
					$icdata_one['chage_state'] = '4';//1:佣金 2:提现  4-二级退货退积分 7退货退奖励金
					$icdata_one['vid'] = $chiefdata['oid'];//变化人的id
					$icdata_one['orid'] = $orderinfo['order_id'];//订单表的id
					$icdata_one['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
					$in_one = $this->integral_chage->add($icdata_one);//积分变化记录end
					if(!$in_one){
		    			M()->rollback();
		    			return false;exit;
		    		}
		    		$this->month_sum($chiefdata['oid'],'',$chiefdata['omoney'],$type);//积分月汇总
		    	}else{
		    		return true;
		    	}
		    	//购买对应身份二级是否有分成,并且存在二级
		    	if(($chiefdata['tmoney'] > 0) && $chiefdata['tid']){//存在二级
		    		$two_sintegral = $this->vip->where("vid=".$chiefdata['tid'])->getField("sintegral");
					//增加二级累计总积分
					$two_in = $this->vip->where("vid=".$chiefdata['tid'])->setDec("integral",$chiefdata['tmoney']);
					//增加二级可用积分
					$two_sin = $this->vip->where("vid=".$chiefdata['tid'])->setDec("sintegral",$chiefdata['tmoney']);
					if(!$two_in || !$two_sin){
		    			M()->rollback();
		    			return false;exit;
		    		}
					//积分变化表需要的数据start
					$icdata_two['ictime'] = time();//时间
					$icdata_two['befor_integral'] = $two_sintegral;//变化前积分
					$icdata_two['after_integral'] = $two_sintegral-$chiefdata['tmoney'];//变化后积分
					$icdata_two['current_integral'] = $chiefdata['tmoney'];//变化积分
					$icdata_two['chage_state'] = '4';//1:佣金 2:提现  4-二级退货退积分 7退货退奖励金
					$icdata_two['vid'] = $chiefdata['tid'];//变化人的id
					$icdata_two['orid'] = $orderinfo['order_id'];//订单表的id
					$icdata_two['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
					$in_two = $this->integral_chage->add($icdata_two);//积分变化记录end
					if(!$in_two){
		    			M()->rollback();
		    			return false;exit;
					}
					$this->month_sum($chiefdata['tid'],$chiefdata['tmoney'],'',$type);//积分月汇总
				}
				//购买对应身份三级是否有分成,并且存在三级
				if(($chiefdata['rmoney'] > 0) && $chiefdata['rid']){//存在三级
					$three_sintegral = $this->vip->where("vid=".$chiefdata['rid'])->getField("smoney");
					//增加三级累计总积分
					$three_in = $this->vip->where("vid=".$chiefdata['rid'])->setDec("money",$chiefdata['rmoney']);
					//增加三级可用积分
					$three_sin = $this->vip->where("vid=".$chiefdata['rid'])->setDec("smoney",$chiefdata['rmoney']);
					if(!$three_in || !$three_sin){
		    			M()->rollback();
		    			return false;exit;
		    		}
					//积分变化表需要的数据start
					$icdata_three['ictime'] = time();//时间
					$icdata_three['befor_integral'] = $three_sintegral;//变化前积分
					$icdata_three['after_integral'] = $three_sintegral-$chiefdata['rmoney'];//变化后积分
					$icdata_three['current_integral'] = $chiefdata['rmoney'];//变化积分
					$icdata_three['chage_state'] = '7';//1:佣金 2:提现  4-二级退货退积分 7退货退奖励金
					$icdata_three['vid'] = $chiefdata['rid'];//变化人的id
					$icdata_three['orid'] = $orderinfo['order_id'];//订单表的id
					$icdata_three['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
					$res = $this->integral_chage->add($icdata_three);//积分变化记录end
					if(!$res){
		    			M()->rollback();
		    			return false;exit;
		    		}
		    		$this->month_sum($chiefdata['rid'],'',$chiefdata['rmoney'],$type);//积分月汇总
				}
			}

			$chiefres = $this->chieflist->where($map)->setField("type",'9');//修改三级记录表数据
			//客服和平台的退货处理
			//客服是否有分成
			$serform['orid'] = $orderinfo['order_id'];//订单id
			$serform['type'] = '9';//9退货的
			$serres = $this->serlist->where($serform)->find();//查找记录
			if($serres){//已经处理过了
				return true;
			}
			$serform['type'] = '0';//9退货的
			$serdata = $this->serlist->where($serform)->find();//查找记录
			if($serdata){//客服有分成
				$sedata['orid'] = $serdata['orid'];//订单的id
				$sedata['pid'] = $serdata['pid'];//项目分类的id
				$sedata['cid'] = $serdata['cid'];//购买人的id
				$sedata['uid'] = $serdata['uid'];//客服的id
				$sedata['money'] = $serdata['money'];//客服分成的金额
				$sedata['time'] = time();//时间
				$sedata['type'] = '9';//9退货的
				$res = $this->serlist->add($sedata);//添加客服退货记录
				if(!$res){
	    			M()->rollback();
	    			return false;exit;
	    		}
			}

			//平台是否有分成
			$platform['orid'] = $orderinfo['order_id'];//订单id
			$platform['type'] = '9';//9退货的
			$platres = $this->platlist->where($platform)->find();//查找记录
			if($platres){//已经处理过了
				return true;
			}
			$platform['type'] = '0';//9退货的
			$platdata = $this->platlist->where($platform)->find();//查找记录
			if($platdata){//平台有分成
				$pldata['orid'] = $platdata['orid'];//订单的id
				$pldata['pid'] = $platdata['pid'];//项目分类的id
				$pldata['cid'] = $platdata['cid'];//购买人的id
				$pldata['pid'] = $platdata['pid'];//项目分类的id
				$pldata['money'] = $platdata['money'];//平台分成的金额
				$pldata['time'] = time();//时间
				$pldata['type'] = '9';//9退货的
				$res = $this->platlist->add($pldata);//添加客服分成记录
				if(!$res){
	    			M()->rollback();
	    			return false;exit;
	    		}
			}
		}else{
			return false;
		}
	}
	//钻石合伙人的分成
	//$orderinfo订单的信息
	//$type 1 购买 2退货
	public function diamonds_Identity($orderinfo,$type){
		if(!in_array($this->identityinfo['id'],$this->diamonds_tc)){//该订单钻石合伙人不存在分成
			return false;exit;
		}
		if($type == '1'){
			if(($this->diamonds_fen['one'] > 0) && $this->diamonds_info['one']['vid']){//一级有分成，并且存在
				$cdata['orid'] = $orderinfo['order_id'];//订单的id
				$cdata['pid'] = $this->pid;//项目分类的id
				$cdata['cid'] = $orderinfo['buyer_id'];//购买人的id
				$cdata['omoney'] = $this->diamonds_fen['one'];//一级拿的钱
				$cdata['oid'] = $this->diamonds_info['one']['vid'];//一级的id
				$this->diamonds_info['one']['smoney'] = $this->vip->where("vid=".$this->diamonds_info['one']['vid'])->getField("smoney");
				//增加一级累计总积分
				$one_in = $this->vip->where("vid=".$this->diamonds_info['one']['vid'])->setInc("money",$this->diamonds_fen['one']);
				//增加一级可用积分
				$one_sin = $this->vip->where("vid=".$this->diamonds_info['one']['vid'])->setInc("smoney",$this->diamonds_fen['one']);
				if(!$one_in || !$one_sin){
	    			M()->rollback();
	    			return false;exit;
	    		}
				//积分变化表需要的数据start
				$icdata_one['ictime'] = time();//时间
				$icdata_one['befor_integral'] = $this->diamonds_info['one']['smoney'];//变化前积分
				$icdata_one['after_integral'] = $this->diamonds_info['one']['smoney']+$this->diamonds_fen['one'];//变化后积分
				$icdata_one['current_integral'] = $this->diamonds_fen['one'];//变化积分
				$icdata_one['chage_state'] = '5';//1:佣金 2:提现 5钻石合伙人分成
				$icdata_one['vid'] = $this->diamonds_info['one']['vid'];//变化人的id
				$icdata_one['orid'] = $orderinfo['order_id'];//订单表的id
				$icdata_one['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
				$in_one = $this->integral_chage->add($icdata_one);//积分变化记录end
				if(!$in_one){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    		$this->month_sum($this->diamonds_info['one']['vid'],'',$this->diamonds_fen['one'],$type);//积分月汇总
			}else{
				return true;
			}

			if(($this->diamonds_fen['two'] > 0) && $this->diamonds_info['two']['vid']){//二级有分成，并且存在
				$cdata['tmoney'] = $this->diamonds_fen['two'];//二级拿的钱
				$cdata['tid'] = $this->diamonds_info['two']['vid'];//二级的id
				$this->diamonds_info['two']['smoney'] = $this->vip->where("vid=".$this->diamonds_info['two']['vid'])->getField("smoney");
				//增加二级累计总积分
				$two_in = $this->vip->where("vid=".$this->diamonds_info['two']['vid'])->setInc("money",$this->diamonds_fen['two']);
				//增加二级可用积分
				$two_sin = $this->vip->where("vid=".$this->diamonds_info['two']['vid'])->setInc("smoney",$this->diamonds_fen['two']);
				if(!$two_in || !$two_sin){
	    			M()->rollback();
	    			return false;exit;
	    		}
				//积分变化表需要的数据start
				$icdata_two['ictime'] = time();//时间
				$icdata_two['befor_integral'] = $this->diamonds_info['two']['smoney'];//变化前积分
				$icdata_two['after_integral'] = $this->diamonds_info['two']['smoney']+$this->diamonds_fen['two'];//变化后积分
				$icdata_two['current_integral'] = $this->diamonds_fen['two'];//变化积分
				$icdata_two['chage_state'] = '5';//1:佣金 2:提现  5钻石合伙人分成
				$icdata_two['vid'] = $this->diamonds_info['two']['vid'];//变化人的id
				$icdata_two['orid'] = $orderinfo['order_id'];//订单表的id
				$icdata_two['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
				$in_two = $this->integral_chage->add($icdata_two);//积分变化记录end
				if(!$in_two){
	    			M()->rollback();
	    			return false;exit;
				}
				$this->month_sum($this->diamonds_info['two']['vid'],'',$this->diamonds_fen['two'],$type);//积分月汇总
			}
			if(($this->diamonds_fen['three'] > 0) && $this->diamonds_info['three']['vid']){//三级有分成，并且存在
				$cdata['rmoney'] = $this->diamonds_fen['three'];//三级拿的钱
				$cdata['rid'] = $this->diamonds_info['three']['vid'];//三级的id
				$this->diamonds_info['three']['smoney'] = $this->vip->where("vid=".$this->diamonds_info['three']['vid'])->getField("smoney");
				//增加三级累计总积分
				$three_in = $this->vip->where("vid=".$this->diamonds_info['three']['vid'])->setInc("money",$this->diamonds_fen['three']);
				//增加三级可用积分
				$three_sin = $this->vip->where("vid=".$this->diamonds_info['three']['vid'])->setInc("smoney",$this->diamonds_fen['three']);
				if(!$three_in || !$three_sin){
	    			M()->rollback();
	    			return false;exit;
	    		}
				//积分变化表需要的数据start
				$icdata_three['ictime'] = time();//时间
				$icdata_three['befor_integral'] = $this->diamonds_info['three']['smoney'];//变化前积分
				$icdata_three['after_integral'] = $this->diamonds_info['three']['smoney']+$this->diamonds_fen['three'];//变化后积分
				$icdata_three['current_integral'] = $this->diamonds_fen['three'];//变化积分
				$icdata_three['chage_state'] = '5';//1:佣金 2:提现 
				$icdata_three['vid'] = $this->diamonds_info['three']['vid'];//变化人的id
				$icdata_three['orid'] = $orderinfo['order_id'];//订单表的id
				$icdata_three['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
				$res = $this->integral_chage->add($icdata_three);//积分变化记录end
				if(!$res){
	    			M()->rollback();
	    			return false;exit;
	    		}
	    		$this->month_sum($this->diamonds_info['three']['vid'],'',$this->diamonds_fen['three'],$type);//积分月汇总
			}
			$cdata['time'] = time();//时间
			$cdata['sort'] = '2';//2为钻石的提成
	        $chres = $this->chieflist->add($cdata);//增加三级积分变化记录
	        
		}else if($type == '2'){
			$map['orid'] = $orderinfo['order_id'];//订单的id
			$map['type'] = '0';//正常
			$map['sort'] = '2';//0三级分的钱 2钻石分的钱
			$chiefdata = $this->chieflist->where($map)->find();//查询数据是否存在
			if(!$chiefdata){//没有上级
	    		return true;
			}else{//添加三级的退货扣减积分
				//购买对应身份一级是否有分成,并且存在一级
				if(($chiefdata['omoney'] > 0) && $chiefdata['oid']){//购买对应身份一级有分成
					$one_sintegral = $this->vip->where("vid=".$chiefdata['oid'])->getField("smoney");
					//增加一级累计总积分
					$one_in = $this->vip->where("vid=".$chiefdata['oid'])->setDec("money",$chiefdata['omoney']);
					//增加一级可用积分
					$one_sin = $this->vip->where("vid=".$chiefdata['oid'])->setDec("smoney",$chiefdata['omoney']);
					if(!$one_in || !$one_sin){
		    			M()->rollback();
		    			return false;exit;
		    		}
					//积分变化表需要的数据start
					$icdata_one['ictime'] = time();//时间
					$icdata_one['befor_integral'] = $one_sintegral;//变化前积分
					$icdata_one['after_integral'] = $one_sintegral-$chiefdata['omoney'];//变化后积分
					$icdata_one['current_integral'] = $chiefdata['omoney'];//变化积分
					$icdata_one['chage_state'] = '7';//1:佣金 2:提现  4-二级退货退积分 7退货退奖励金
					$icdata_one['vid'] = $chiefdata['oid'];//变化人的id
					$icdata_one['orid'] = $orderinfo['order_id'];//订单表的id
					$icdata_one['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
					$in_one = $this->integral_chage->add($icdata_one);//积分变化记录end
					if(!$in_one){
		    			M()->rollback();
		    			return false;exit;
		    		}
		    		$this->month_sum($chiefdata['oid'],'',$chiefdata['omoney'],$type);//积分月汇总
		    	}else{
		    		return true;
		    	}
		    	//购买对应身份二级是否有分成,并且存在二级
		    	if(($chiefdata['tmoney'] > 0) && $chiefdata['tid']){//存在二级
		    		$two_sintegral = $this->vip->where("vid=".$chiefdata['tid'])->getField("smoney");
					//增加二级累计总积分
					$two_in = $this->vip->where("vid=".$chiefdata['tid'])->setDec("money",$chiefdata['tmoney']);
					//增加二级可用积分
					$two_sin = $this->vip->where("vid=".$chiefdata['tid'])->setDec("smoney",$chiefdata['tmoney']);
					if(!$two_in || !$two_sin){
		    			M()->rollback();
		    			return false;exit;
		    		}
					//积分变化表需要的数据start
					$icdata_two['ictime'] = time();//时间
					$icdata_two['befor_integral'] = $two_sintegral;//变化前积分
					$icdata_two['after_integral'] = $two_sintegral-$chiefdata['tmoney'];//变化后积分
					$icdata_two['current_integral'] = $chiefdata['tmoney'];//变化积分
					$icdata_two['chage_state'] = '7';//1:佣金 2:提现  4-二级退货退积分 7退货退奖励金
					$icdata_two['vid'] = $chiefdata['tid'];//变化人的id
					$icdata_two['orid'] = $orderinfo['order_id'];//订单表的id
					$icdata_two['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
					$in_two = $this->integral_chage->add($icdata_two);//积分变化记录end
					if(!$in_two){
		    			M()->rollback();
		    			return false;exit;
					}
					$this->month_sum($chiefdata['tid'],'',$chiefdata['tmoney'],$type);//积分月汇总
				}
				//购买对应身份三级是否有分成,并且存在三级
				if(($chiefdata['rmoney'] > 0) && $chiefdata['rid']){//存在三级
					$three_sintegral = $this->vip->where("vid=".$chiefdata['rid'])->getField("smoney");
					//增加三级累计总积分
					$three_in = $this->vip->where("vid=".$chiefdata['rid'])->setDec("money",$chiefdata['rmoney']);
					//增加三级可用积分
					$three_sin = $this->vip->where("vid=".$chiefdata['rid'])->setDec("smoney",$chiefdata['rmoney']);
					if(!$three_in || !$three_sin){
		    			M()->rollback();
		    			return false;exit;
		    		}
					//积分变化表需要的数据start
					$icdata_three['ictime'] = time();//时间
					$icdata_three['befor_integral'] = $three_sintegral;//变化前积分
					$icdata_three['after_integral'] = $three_sintegral-$chiefdata['rmoney'];//变化后积分
					$icdata_three['current_integral'] = $chiefdata['rmoney'];//变化积分
					$icdata_three['chage_state'] = '7';//1:佣金 2:提现  4-二级退货退积分 7退货退奖励金
					$icdata_three['vid'] = $chiefdata['rid'];//变化人的id
					$icdata_three['orid'] = $orderinfo['order_id'];//订单表的id
					$icdata_three['ovid'] = $orderinfo['buyer_id'];//消费的会员vid
					$res = $this->integral_chage->add($icdata_three);//积分变化记录end
					if(!$res){
		    			M()->rollback();
		    			return false;exit;
		    		}
		    		$this->month_sum($chiefdata['rid'],'',$chiefdata['rmoney'],$type);//积分月汇总
				}
			}

			$chiefres = $this->chieflist->where($map)->setField("type",'9');//修改三级记录表数据
		}else{
			return false;
		}
		
	}
	
	//查询上级信息
	//上级会员的邀请码$ikey
	//成功返回true并存入上三级信息 
	//public $one = '';//第一级信息; 
	//public $two = '';//第二级信息; 
	//public $three = '';//第三级信息;
	//$type 1购买 2退货
	//失败返回false
	public function superior($ikey,$type){
		if($type == '1'){
			if($this->pid == '3'){//当项目分类为课程时查询对应的vip表三级信息
				if(!$this->one){//查询第一级
					$omap['vkey'] = array("like",$ikey);
					$this->one = $this->vip->where($omap)->find();

					if(!$this->one){//没有第一级时结束
						return true;
					}
				}
				if(!$this->two){//查询第二级
					$tmap['vkey'] = array("like",$this->one['ikey']);
					$this->two = $this->vip->where($tmap)->find();

					if(!$this->two){//没有第二级时结束
						return true;
					}
				}
				if(!$this->three){//查询第三级
					$thmap['vkey'] = array("like",$this->two['ikey']);
					$this->three = $this->vip->where($thmap)->find();

					if(!$this->three){//没有第三级时结束
						return true;
					}
				}
			}else{//不是则查询三级表的信息
				$remap['vid'] = $this->order->where("order_id=".$this->orid)->getField("buyer_id");
				$ikey = $this->vip_relationship->where($remap)->getField("ikey");
				if(!$this->one){//查询第一级
					$omap['vkey'] = array("like",$ikey);
					$map['vid'] = $this->vip_relationship->where($omap)->getField("vid");
					$this->one = $this->vip->where($map)->find();
					if(!$this->one){//没有第一级时结束
						return true;
					}
				}
				if(!$this->two){//查询第二级
					$tmap['vkey'] = array("like",$this->one['ikey']);
					$map['vid'] = $this->vip_relationship->where($tmap)->getField("vid");
					$this->one = $this->vip->where($map)->find();
					if(!$this->two){//没有第二级时结束
						return true;
					}
				}
				if(!$this->three){//查询第三级
					$thmap['vkey'] = array("like",$this->two['ikey']);
					$map['vid'] = $this->vip_relationship->where($thmap)->getField("vid");
					$this->one = $this->vip->where($map)->find();
					if(!$this->three){//没有第三级时结束
						return true;
					}
				}
			}
			
		}else if($type == '2'){
			$map['sort'] = '0';//三级的
			$map['orid'] = $this->orid;//订单id
			$chieflistdata = $this->chieflist->where($map)->find();
			if($chieflistdata){
				if($chieflistdata['oid']){
					$this->one = $this->vip->where("vid=".$chieflistdata['oid'])->find();//一级
				}else{//没有一级
					return true;
				}
				if($chieflistdata['tid']){
					$this->two = $this->vip->where("vid=".$chieflistdata['tid'])->find();//二级
				}else{//没有二级
					return true;
				}
				if($chieflistdata['rid']){
					$this->three = $this->vip->where("vid=".$chieflistdata['rid'])->find();//三级
				}else{//没有三级
					return true;
				}
				
				return true;
			}else{
				return true;
			}
		}else{
			return false;
		}

	}
	//查询钻石合伙人的信息
	////$type 1购买 2退货
	public function diamonds_superior($ikey,$type){
		if($type == '1'){
			if(!$this->diamonds_info['one'] && $ikey){//查询第一级
				$i_one = 0;
				while ($i_one < 1) {
				    $omap['vkey'] = array("like",$ikey);
					//$omap['diamonds'] = '1';//1为钻石合伙人
					$this->diamonds_info['one'] = $this->vip->where($omap)->find();
				
					if($this->diamonds_info['one']['diamonds'] == 1){//查询到第一级时结束
						$i_one++;
					}else if(!$this->diamonds_info['one']){//没有第一级时结束
						return true;
					}else{//不是钻石继续查询
						$ikey = $this->diamonds_info['one']['ikey'];
					}
				}
			}else{
				return true;
			}
			if(!$this->diamonds_info['two'] && $this->diamonds_info['one']){//查询第二级
				$ikey = $this->diamonds_info['one']['ikey'];
				$i_two = 0;
				while ($i_two < 1) {
				    $tmap['vkey'] = array("like",$ikey);
					$this->diamonds_info['two'] = $this->vip->where($tmap)->find();
				
					if($this->diamonds_info['two']['diamonds'] == 1){//查询到第二级时结束
						$i_two++;
					}else if(!$this->diamonds_info['two']){//没有第二级时结束
						return true;
					}else{//不是钻石继续查询
						$ikey = $this->diamonds_info['two']['ikey'];
					}
				}
			}else{
				return true;
			}
			if(!$this->diamonds_info['three'] && $this->diamonds_info['two']){//查询第三级
				$ikey = $this->diamonds_info['two']['ikey'];
				$i_three = 0;
				while ($i_three < 1) {
				    $thmap['vkey'] = array("like",$ikey);
					$this->diamonds_info['three'] = $this->vip->where($thmap)->find();
				
					if($this->diamonds_info['three']['diamonds'] == 1){//查询到第三级时结束
						$i_three++;
					}else if(!$this->diamonds_info['three']){//没有第三级时结束
						return true;
					}else{//不是钻石继续查询
						$ikey = $this->diamonds_info['three']['ikey'];
					}
				}
			}else{
				return true;
			}
		}else if($type == '2'){
			$map['sort'] = '2';//钻石的
			$map['orid'] = $this->orid;//订单id
			$chieflistdata = $this->chieflist->where($map)->find();
			if($chieflistdata){
				if($chieflistdata['oid']){
					$this->diamonds_info['one'] = $this->vip->where("vid=".$chieflistdata['oid'])->find();//一级
				}
				if($chieflistdata['tid']){
					$this->diamonds_info['two'] = $this->vip->where("vid=".$chieflistdata['tid'])->find();//二级
				}
				if($chieflistdata['rid']){
					$this->diamonds_info['three'] = $this->vip->where("vid=".$chieflistdata['rid'])->find();//三级
				}
				return true;
			}else{
				return true;
			}
		}else{
			return false;
		}
	}
	//积分月汇总表的数据
	//$vid 会员的id
	//$credit 三级奖励
	//$bcredit 钻石奖励
	//$type 1购买 2 退货
	public function month_sum($vid,$credit,$bcredit,$type){
		if($type == '1'){
			$credit = $credit;
			$bcredit = $bcredit;
		}else if($type == '2'){
			$credit = 0-$credit;
			$bcredit = 0-$bcredit;
		}else{
			return true;
		}
		$map['year_month'] = array("like",date("Y-m",time()));//当前月的时间
		$map['vid'] = $vid;//会员的id
		$monthres = $this->month_credit->where($map)->find();

		//判断是否存在记录
		if($monthres){//累加记录
			if($credit){
				$creditres = $this->month_credit->where($map)->setInc("credit",$credit);//三级奖励累加
			}else{
				$creditres = true;
			}
			if($bcredit){
				$bcredit = $this->month_credit->where($map)->setInc("bcredit",$bcredit);//三级奖励累加
			}else{
				$bcredit = true;
			}

			if($creditres && $bcredit){
				return true;
			}else{
				M()->rollback();
				return false;exit;
			}
		}else{//添加记录
			$data['vid'] = $vid;
			$data['year_month'] = date("Y-m",time());
			$data['month'] = strtotime($data['year_month']."-01");//当月开始时间戳
			$data['credit'] = $credit;//三级奖励
			$data['bcredit'] = $bcredit;//钻石奖励
			$monthdata = $this->month_credit->add($data);//添加记录
			if($monthdata){
				return true;
			}else{
				M()->rollback();
				return false;exit;
			}
		}
	}
}
?>