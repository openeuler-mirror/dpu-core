dpu接口设计.md

```
  1.弹性网卡
  2.弹性云盘
  3.meter限速
  4.traffic control流量控制
  5.端口统计显示
  6.光口管理
```

## 1. 弹性网卡
### 1.1 capability 
   获取支持的能力
   
  ``` 
   message GetPortCapabilityRequest{
   
   }
   
   message GetPortCapabilityResponse{
       required uint32 status = 1;          /*操作成功与否*/
       required uint32 total_pvf_cnt = 2;   /*支持的网卡总个数*/
       required uint32 free_pvf_cnt = 3;    /*当前还可创建的网卡个数*/
   }
   ```
   
### 1.2 add port
   添加弹性网卡.
   
   ```
   message NewPortRequest { 
     required string uuid = 1;     /*上层业务侧分配给网卡的id*/
     optional uint32 vport  =2;    /* port id */
     optional uint32 max_qpair = 3;
     optional uint32 mtu = 4;    
     optional bytes  mac = 5; 
     optional uint32 queue_depth = 6;   
	 optional uint64 feature_list = 7;
   }

   message PortOpsRep {
     required uint32 status = 1; /*操作成功与否*/
     required uint32 vport = 2;
   }
   ```
   
### 1.3 del port

   删除指定弹性网卡
   
   ```
   message DelPortRequest {
     required uint32 vport = 1;	/* port id */
   }
   
   message PortOpsRep {
     required uint32 status = 1; 
     required uint32 vport = 2;
   }
   ```
   
### 1.4 update port

   更新指定弹性网卡的特性
   
   ```
   message SetPortCfgRequest{
     required uint32 vport = 1;
     optional uint32 mtu = 2;
     optional uint32 max_qpair = 3;          
     optional uint32 queue_depth = 4;
     optional bytes mac = 5;
	 optional uint64 feature_list = 6;
   }
   
   message PortOpsRep {
     required uint32 status = 1;
     required uint32 vport = 2;
   }
   ```
   
### 1.5 get port

   获取弹性网卡的配置
   
   ```
   message GetPortCfgRequest {
     required uint32 vport = 1;	
   }
   
   message GetPortCfgResponse {
     required uint32 status = 1;
     required bool	enable = 2;		/*是否创建*/       
     required uint32 max_qpair = 3;  
     required uint32 mtu = 4;		     
     required bytes mac = 5;
     required string uuid = 6;
     required uint32 vport = 7;	/* port id */
     required uint32 queue_depth = 8;
     required uint32 active_qpair = 9; 	 
   }
   ```
   
### 1.6 list

   获取所有弹性网卡pf配置信息。
   
   ```   
   message QueryPortRequest {
   }
   
   message PortCfg{
     required uint32 queue_depth = 1;	
     required bool	enable = 2;		          
     required uint32 max_qpair = 3;  
     required uint32 mtu = 4;		     
     required bytes mac = 5;
     required string uuid = 6;
     required uint32 vport = 7;	/*PVF */
	 required uint32 active_qpair = 8; 	 
      
   }
   
   
   message QueryPortResponse {
     required uint32 status = 1; /*操作成功与否*/
     repeated PortCfg ports = 2;
   }
   ```
   
## 2. 云盘
### 2.1 capability

   获取最大支持多少云盘，还可以支持的云盘个数。
   
   ```
   message VdiskGetPvfCapabilityRequest{
   }
   message VdiskGetPvfCapabilityResponse{
     required uint32 status = 1;             /*操作成功与否*/
     required uint32 total_pvf_cnt = 2;      /*总的支持创建云盘个数*/
     required uint32 free_pvf_cnt = 3;        /*当前还可创建云盘个数*/
   }
   ```
### 2.2 create vdisk

  创建云盘。
	 
  ```
    message VdiskCreateRequest{
	  required string name = 1;      *上层业务侧分配给云盘的名称*/
      optional uint32 pvf_id = 2;
      optional uint32 max_queue = 3;
      optional uint32 queue_depth = 4;
      optional uint32 msix = 5;
    }
    
    message VdiskOpsRsp{
	  requered uint32 status =1;
      required uint32 pvf_id = 2;
	  
    }
  ```

### 2.3 del vdisk

  删除云盘
	
  ```
    message VdiskDestroyRequest{
      required uint32 pvf_id = 1;
    }
    
    message VdiskOpsRsp{
	  requered uint32 status =1;
      required uint32 pvf_id = 2;
	  
    }
  ```
### 2.4 resize vdisk  

   云盘扩容
	 
  ```
     message VdiskUpdateRequest{
       required uint32 pvf_id = 1;
       optional uint64 number_secotrs = 2; 
  
     }
     
     message VdiskOpsRsp{
	  requered uint32 status =1;
      required uint32 pvf_id = 2;
	  
    }
  ```
### 2.5 pause vdisk

  启停云盘的流量 
  pause：true 对指定pvf_id的云盘做停流操作；false 重新启动pvf_id对应的云盘的流量。
	
  ```
    message VdiskPauseRequest{
      required uint32 pvf_id = 1;
      required bool pause = 3; 
    }
	message VdiskOpsRsp{
	  requered uint32 status =1;
      required uint32 pvf_id = 2;
	  
    }
  ```
### 2.6 get vdisk

  获取云盘配置信息
	 
  ```
	 enum PvfType{
	   PF_TYPE = 0;
       VF_TYPE = 1;
     }
     message VdiskGetPvfCfgRequest{
       required uint32 pvf_id = 1;
     }
     
     message VdiskGetPvfCfgResponse{
	   requered uint32 status = 1;
	   required uint32 pvf_id = 2;
       required bool	enable = 3;	
       required uint32 max_queue = 4;
       required uint32 msix_num = 5;
       required uint32 queue_depth = 6;
       required uint64 sector_num = 7;
       required uint32 nr_active_queue = 8;
       required uint32 trans_status = 9; 
       required string name = 10;
       required PvfType port_type = 11;
       	   
	   
     }
   ```
	 
### 2.7 list vdisk 

   获取所有云盘信息
	 
   ```
     message VdiskGetAllPvfCfgRequest{
       required bool get_from_hard = 1;
     }
     
     message VdiskGetPvfCfg{
       required uint32 pvfid = 1;
       required bool	enable = 2;	
       required uint32 max_queue = 3;
       required uint32 msix_num = 4;
       required uint32 queue_depth = 5;
       required uint64 sector_num = 6;
       required uint32 nr_active_queue = 7;
       required uint32 trans_status = 8; 
       required string name = 9;
       required PvfType port_type = 10;
     }
     message VdiskGetAllPvfCfgResponse{
	   required uint32 status = 1;
       repeated VdiskGetPvfCfg cfgs = 2;
     }
  ```
	 
## 3. meter

### 3.1 capability

  获取可配置的meter表的个数
	 
```
     message MeterCapabilityRequest{
     }
     message MeterCapabilityResponse{
	   required uint32 status = 1;
       required uint32 total = 2;  /*总的meter表个数*/
	   requered uitn32 free = 3;   /*当前剩余可配meter表个数*/
     }
 ```
### 3.2 add 

   添加meter限速表
	 
  ```
     message MeterAddRequest{
       required uint32 id = 1;
       required uint32 rate = 2;
     }
     message MeterOpsRsp{
	   required uint32 status = 1;
	   required uint32 id = 2;
       
     }
  ```
	 
### 3.3 del

   删除meter限速表
	 
  ```
     message MeterDelRequest{
       required uint32 id = 1;

     }
     message MeterOpsRsp{
	   required uint32 status = 1;
	   required uint32 id = 2;
       
     }
  ```
	 
### 3.4 update

   更新meter限速表
	 
  ```
     message MeterUpdateRequest{
       required uint32 id = 1;
       required uint32 rate = 2;
     }
     message MeterOpsRsp{
	   required uint32 status = 1;
	   required uint32 id = 2;
       
     }
   ```
	 
### 3.5 get

   获取meter限速表
	 
   ```
     message MeterGetRequest{
       required uint32 id = 1;
     }
     message MeterGetResponse{
	   required uint32 status = 1;
	   required uint32 id = 2;
       required uint32 rate = 3;
       requered uint32 type = 4 ;
	   
     }
   ```
	 
## 4. traffic control
### 4.1 分流规则

  分流规则匹配域和action域的内容如下：
	
  ```
	匹配分流规则后的action
    message RuleAction{
    	required int32 qid = 2;
    	required int32 vid = 3;
    }
	分流规则匹配项。
    message MaskRuleKey{
    	required int32 key_index = 1;
    	required bytes dmac = 2;	
    	required bytes smac = 3;	
    	required int64  dmac_mask = 4;
    	required int64  smac_mask = 5;
    	repeated uint32 dip = 6;   
    	repeated uint32 dip_mask = 7;
    	repeated uint32 sip = 8;
    	repeated uint32 sip_mask = 9;
    	required int32  dl4port = 10;
    	required int32  dl4port_mask = 11;
    	required int32  sl4port = 12;
    	required int32  sl4port_mask =13;
    	required int32  vlan = 14;
    	required int32  vlan_mask = 15;
    	required int32  vid =16;
    	required int32  vid_mask = 17;
    	required string ip_type = 18;
    	required int32 ipprotocol = 19;
    	required int32 ipprotocol_mask = 20;
    }
  ```
   
（1）classfiler rule set
 设置分流规则
	
  ```
    message ClassfierWriteRequest{
      required MaskRuleKey mask_rule_key=2;
      required RuleAction  action =3;
	  required int32 key_index = 1;

    }
    message ClassfierOpsRsp{
	  required uint32 status = 1;
      required int32 key_index = 2;
	  
    }
  ```
   
（2）classfiler rule del
 删除分流规则
	
  ```
    message ClassfierDeleteRequest{
      required int32 key_index =1;
    }
    
    message ClassfierOpsRsp{
	  required uint32 status = 1;
      required int32 key_index = 2;
	  
    }
  ```

（3）classfiler rule get
 获取分流规则
	
```
    message ClassfierReadRequest{
      required int32 key_index =1;
    }
    
    message ClassfierReadResponse{
	  required uint32 status = 1;
      required RuleAction  action =2;
      required MaskRuleKey mask_rule_key=3; 
	  
    }
```

### 4.2 soc端口流量切换

  将发送给soc某个端口的流量切换到soc上另一个端口上。
	
  ```
    message ProcSwitchRequest{
      required uint32 src_pfid = 1;   
      required uint32 dest_pfid = 2;  
    
    }
    
    message ProcSwitchResponse{
	  required uint32 status = 1;
    }
  ```
	
## 5. 端口统计显示

  获取host/soc侧virtio pf口的统计。
	
  ```
    message GetPortStatsRequest{
      required uint32 vid = 1;   
    }
    
    message GetPortStatsResponse{
	    required uint32 status = 1;
        required uint64 rx_packets = 2;
        required uint64 tx_packets = 3;
        required uint64 rx_bytes = 4;
        required uint64 tx_bytes = 5;
        required uint64 rx_drop = 6;
        required uint64 tx_drop = 7;
        required uint64 rx_error = 8;
        required uint64 tx_error = 9;
		required uint32 vid = 10;
		
    }
	
  ```
## 6. 光口管理

建议在sco实现映射口作为光口的体现。
可通过映射口的操作来操作光口，光口状态变化，也能在映射口都体现出来。

### 6.1 bond使能

  ```
    message EthMacBondSetRequest{
      required bool enable = 1;
    }
    
    message EthMacBondSetResponse{
	  required uint32 status = 1;
    }
  ```
	
### 6.2 获取统计

  ```
	message EthMacGetStatsRequest{
      required uint32 port_id = 1; /*光口id*/
    }
	
	message EthMacGetStatsResponse {
	  required uint32 status = 1;
      required uint64 ipackets = 2;  /**< Total number of successfully received packets. */
      required uint64 opackets = 3;  /**< Total number of successfully transmitted packets.*/
      required uint64 ibytes = 4;    /**< Total number of successfully received bytes. */
      required uint64 obytes = 5;    /**< Total number of successfully transmitted bytes. */
      required uint64 imissed = 6;
      /**< Total of RX packets dropped by the HW,
       * because there are no available buffer (i.e. RX queues are full).
       */
      required uint64 ierrors = 7;   /**< Total number of erroneous received packets. */
      required uint64 oerrors = 8;   /**< Total number of failed transmitted packets. */
      required uint64 rx_nombuf = 9; /**< Total number of RX mbuf allocation failures. */
      repeated uint64 q_ipackets = 10;   
      /**< Total number of queue RX packets. */
      repeated uint64 q_opackets = 11;
      /**< Total number of queue TX packets. */
      repeated uint64 q_ibytes = 12;
      /**< Total number of successfully received queue bytes. */
      repeated uint64 q_obytes = 13;
      /**< Total number of successfully transmitted queue bytes. */
      repeated uint64 q_errors = 14;
      /**< Total number of queue packets received that are dropped. */ 
	  
    };
  ```
	
### 6.3 获取光口状态

  ```  
      message EthMacGetLinkRequest{   
        required uint32 port_id = 1; /*光口id*/
		
      }
      
      message EthMacGetLinkResponse{
	    required uint32 status = 1;
        required EthLink link = 2;
		
      }
	  
	  message EthLink {
        required uint32 link_speed = 1;        /**< ETH_SPEED_NUM_ */
        required bool link_duplex  = 2;  /**< ETH_LINK_[HALF/FULL]_DUPLEX */
        required bool link_autoneg = 3;  /**< ETH_LINK_[AUTONEG/FIXED] */
        required bool link_status  = 4;  /**< ETH_LINK_[DOWN/UP] */
      }
  ```
	  
### 6.4 获取光口mtu

  ```
      message EthMacGetMtuRequest{
        required uint32 port_id = 1;  /*光口id*/
      }
      
      message EthMacGetMtuResponse{
	    required uint32 status = 1;
        required uint32 mtu = 2;
		required uint32 port_id = 3;
      }
  ```
	  
### 6.5 设置光口mtu

  ```
	  message EthMacSetMtuRequest{
        required uint32 port_id = 1; /*光口id*/
        required uint32 mtu = 2;
      }
      
      message EthMacSetMtuResponse{
	    required uint32 status = 1;
        required uint32 port_id = 2;
      }
   ```