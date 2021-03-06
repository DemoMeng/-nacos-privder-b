package com.mqz.nacos.provider.b.web;

import com.mqz.nacos.provider.b.common.WebRequestMapping;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author mqz
 * @description
 * @abount https://github.com/DemoMeng
 * @since 2021/2/24
 */
@RestController
@RequestMapping(WebRequestMapping.PREFIX+"/feign")
@RefreshScope //动态刷新读取Nacos配置文件
@Api(tags = "web测试-提供feign入口",value = "web测试-提供feign")
public class FeignHttpController {

    private final static Logger log = LoggerFactory.getLogger(FeignHttpController.class);


    @GetMapping("/call")
    @ApiOperation(value = "提供feign调用接口")
    public String index(){
        log.info("Nacos客户端[nacos-provider-a:节点b]收到请求");
        return String.format("Nacos客户端[nacos-provider-a:节点b]:返回了数据");
    }



}
