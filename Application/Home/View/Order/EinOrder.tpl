
<img src="__Assert__/img/excel.png" width="600px" height="300">
<iframe name="formadd_sq" style="display:none;"></iframe>
                        <form role="form" method="post" action="{:U('Dym/inExcel')}" onsubmit="return" enctype="multipart/form-data" class="form-horizontal form-seperated shequn validform  window_main" target="formadd_sq">
                            <div class="box-body">
                                <div>
                                    <label>
                                       订单表格：<span style="color: #FF0000;">(xls后缀的，按照上图的格式来提交表格，否则会有问题)</span>
                                    
                                   <input type="file" name="file"  style='width:30%;' />
                                    </label>
                                </div>
                         
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary" id="submit">提交</button>
              
                            </div>
                        </form>