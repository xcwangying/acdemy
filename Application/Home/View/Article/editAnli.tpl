<extend name="Public/base"/>
<block name="css">
    <link rel="stylesheet" href="__Assert__/plugins/datatables/dataTables.bootstrap.css">

</block>

<block name="content">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                名片详情<if condition="$vip.vname neq ''">->{$vip.vname}</if><if condition="$vip.vphone neq ''">->{$vip.vphone}</if>

            </h1>
            <ol class="breadcrumb">
                <li>管理后台</li>
                <li>推广海报</li>
                <li class="active">海报详情</li>
            </ol>
        </section>

        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-body">
                            <div class="row">
                            <div class="col-sm-6">
                                <div class="dataTables_length">
                                <a href="{:U('Article/Cardcaseindex')}" class="btn btn-primary btn-sm">返回</a>
                                    <!-- <label>
                                        <a href="{:U('Adhere/addIndex')}" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>&nbsp;添加文章</a>
                                        <php>if(isset($_GET['searchtext']) && !empty($_GET['searchtext'])){</php>
                                        <a href="{:U('Adhere/index')}"><input type="button" class="btn btn-sm btn-primary" value="撤销搜索"></a>
                                        <php>}</php>
                                    </label> -->
                                </div>
                            </div>
                            <form class="searchform" method="get">
                              <div class="col-sm-6">
                                    <!-- <div class="dataTables_filter">
                                        <label>
                                            <div class="dataTables_filter">
                                                <input type="text" class="input_ser input-sm form-control ui-widget" name="searchtext" value="{$_GET['searchtext']}" placeholder="输入名称搜索..." style="width:157px;"/>
                                                <button class="form-control btn btn-default btn-sm" style="width: auto;margin-top: -2px; vertical-align: middle; height: 30px;"><i class="fa fa-search"></i></button>
                                            </div>
                                        </label>
                                    </div>
                                                                    </div> -->
                            </form>
                        </div>

                      
                            <div class="col-sm-12">
                                
                                    <table id="example1" class="table table-bordered table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th class="text-center">序号</th>
                                                <th class="text-center">标题</th>
                                                <th class="text-center">图片</th>
                                                <th class="text-center">发布时间</th>
                                                <th class="text-center">状态</th>
                                                <th class="text-center">操作</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <if condition="$info">
                                          <volist name="info" id="item">
                                            <tr>
                                                <td class="text-center" style="padding-top:20px;">{$i}</td>
                                                <td class="text-center" style="padding-top:20px;">{$item.title}</td>
                                              <td class="text-center">

                                              <if condition="$item.img1 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img1}" widtd='54' height='54' />&nbsp;&nbsp;&nbsp;&nbsp;
                                              </if>

                                              <if condition="$item.img2 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img2}" widtd='54' height='54' />&nbsp;&nbsp;&nbsp;&nbsp;
                                              </if>

                                              <if condition="$item.img3 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img3}" widtd='54' height='54' />&nbsp;&nbsp;&nbsp;&nbsp;
                                              </if>

                                              <if condition="$item.img4 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img4}" widtd='54' height='54' />&nbsp;&nbsp;&nbsp;&nbsp;
                                              </if>

                                              <if condition="$item.img5 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img5}" widtd='54' height='54' />&nbsp;&nbsp;&nbsp;&nbsp;
                                              </if>

                                              <if condition="$item.img6 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img6}" widtd='54' height='54' />&nbsp;&nbsp;&nbsp;&nbsp;
                                              </if>

                                              <if condition="$item.img7 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img7}" widtd='54' height='54' />&nbsp;&nbsp;&nbsp;&nbsp;
                                              </if>

                                              <if condition="$item.img8 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img8}" widtd='54' height='54' />&nbsp;&nbsp;&nbsp;&nbsp;
                                              </if>

                                              <if condition="$item.img9 neq NULL">
                                              	<img src="<?php echo C('ZDYOSSWZ') ?>/{$item.img9}" widtd='54' height='54' />
                                              </if>

                                              </td>
                                              <td class="text-center" style="padding-top:20px;">{$item.time|date="Y-m-d H:i:s",###}</td>
                                              <?php if($item['status']==1){ ?>
                                                <td class="text-center" style="padding-top:20px;color:green"><b>展示中</b></td>
                                              <?php }else{ ?>
                                                <td class="text-center" style="padding-top:20px;color:red"><b>违规</b></td>
                                              <?php } ?>
                                              <if condition="$item.status eq '2'">
                                                <td class="text-center" style="padding-top:20px;"><a href="{:U('Article/goimg')}?id={$item.id}&vid={$item.vid}">点击上架</a></td>
                                              <else/>
                                  			  <td class="text-center" style="padding-top:20px;"><a href="{:U('Article/delimg')}?id={$item.id}&vid={$item.vid}">违规下架</a></td>
                                              </if>
                                            </tr>
                                          </volist>
                                          <else />
                                          <tr>
                                                    <td class="into" colspan="6" style="vertical-align:middle;font-size:30px;" height="200">暂无信息</td>
                                                </tr>
                                            </if>
                                        </tbody>
                                    </table>                          
                            </div>
                        <if condition="$info">
                        <div class="">
                            <div class="col-sm-5">
                                <div class="dataTables_info">
                                    <span>共有<code>{$count}</code>条记录</span>
                                </div>
                            </div>
                            <div class="col-sm-7">
                                <div class="dataTables_paginate paging_simple_numbers">
                                    <ul class="pagination">
                                        {$page}
                                    </ul>
                                </div>
                            </div>
                        </div>
                        </if>

                  </div>
              </div>
          </div>
      </section>
  </div>
</block>
<block name="js">
    <script src="__Assert__/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="__Assert__/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script>
        // function ajaxSold(id) {
        //     if (confirm('是否隐藏')) {
        //         $.get("{:U('Adhere/solds')}?id=" + id, function (data, status) {
        //             if (status == 'success') {
        //                 layer.msg(data.msg);
        //             } else {
        //                 layer.msg('系统错误');
        //             }
        //             window.location.reload();
        //         }, 'json');
        //     }
        // }
        // function ajaxUnsold(id) {
        //     if (confirm('是否显示')) {
        //         $.get("{:U('Adhere/unsolds')}?id=" + id, function (data, status) {
        //             if (status == 'success') {
        //                 layer.msg(data.msg);
        //                 setTimeout(function () {
        //                     window.location.reload();
        //                 }, 1500);
        //             } else {
        //                 layer.msg('系统错误');
        //             }
        //         }, 'json');
        //     }
        // }

        function showImg(img) {
            layer.open({
                type: 1,
                title: '主图',
                closeBtn: 2,
                shade: 0.5,
                content: "<img width='100%' height='100%' src='"+img+"'/>",
            });
        }
    </script>
</block>