package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.class_37;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2466;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.utils.CommunicationUtils;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   
   [SecureSWF(rename="true")]
   public class class_2954 extends EventDispatcherWrapper
   {
      
      public static const ENVIRONMENT_SELECTED_EVENT:String = "ENVIRONMENT_SELECTED_EVENT";
      
      private var var_1635:class_16;
      
      private var _windowManager:class_37;
      
      private var var_3477:class_40;
      
      private var var_4954:class_1741;
      
      private var var_1092:int;
      
      private var var_548:class_2466;
      
      private var var_3328:String;
      
      public function class_2954(param1:class_2466, param2:class_16, param3:class_37, param4:class_40)
      {
         super();
         var_1635 = param2;
         _windowManager = param3;
         var_3477 = param4;
         var_548 = param1;
         init();
      }
      
      public function get selectedEnvironment() : String
      {
         return var_3328;
      }
      
      override public function dispose() : void
      {
         var_548 = null;
         super.dispose();
      }
      
      private function getAvailableEnvironments() : Array
      {
         return var_1635.getProperty("live.environment.list").split("/");
      }
      
      private function createListItem(param1:String) : class_1741
      {
         var _loc2_:XmlAsset = var_3477.getAssetByName(param1) as XmlAsset;
         return _windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function init() : void
      {
         var_4954 = createListItem("login_environment_list_item");
         var _loc3_:Array = getAvailableEnvironments();
         var _loc1_:String = CommunicationUtils.readSOLString("environment");
         _loc1_ = _loc1_ == null ? "d63" : _loc1_;
         var _loc4_:Array = getEnvironmentNames(_loc3_);
         var_3328 = _loc1_;
         var _loc7_:int = var_548.numMenuItems;
         var _loc5_:int = 0;
         while(0 < _loc7_)
         {
            var_548.removeMenuItemAt(0);
            _loc5_++;
         }
         for each(var _loc2_ in _loc4_)
         {
            var _loc6_:class_1812 = var_4954.clone() as class_1812;
            _loc6_.findChildByName("title").caption = _loc2_;
            var_548.addMenuItem(null);
         }
         var_548.selection = _loc3_.indexOf(_loc1_);
         var_548.procedure = dropMenuEventHandler;
         var_1092 = -1;
         testEnvironmentAvailable(false);
      }
      
      private function testEnvironmentAvailable(param1:Boolean) : void
      {
         var environmentIds:Array;
         var window:class_1812;
         var environment:String;
         var host:String;
         var ports:Array;
         var socket:Socket;
         var lastEnvironmentConnected:Boolean = param1;
         if(_disposed || var_548 == null || Boolean(var_548.disposed))
         {
            return;
         }
         environmentIds = getAvailableEnvironments();
         if(var_548 && var_1092 > -1 && var_1092 < var_548.numMenuItems)
         {
            window = var_548.getMenuItemAt(var_1092) as class_1812;
            (window.findChildByName("icon") as IStaticBitmapWrapperWindow).assetUri = lastEnvironmentConnected ? "help_accept_icon" : "help_decline_icon";
         }
         var_1092 = var_1092 + 1;
         if(var_1092 >= environmentIds.length)
         {
            return;
         }
         environment = environmentIds[var_1092];
         host = var_1635.getProperty("connection.info.host." + environment);
         ports = var_1635.getProperty("connection.info.port." + environment).split(",");
         socket = new Socket();
         socket.addEventListener("connect",function(param1:Event):void
         {
            (param1.target as Socket).close();
            testEnvironmentAvailable(true);
         });
         socket.addEventListener("complete",function(param1:Event):void
         {
            (param1.target as Socket).close();
         });
         socket.addEventListener("close",function(param1:Event):void
         {
            (param1.target as Socket).close();
         });
         socket.addEventListener("socketData",function(param1:ProgressEvent):void
         {
            (param1.target as Socket).close();
         });
         socket.addEventListener("securityError",function(param1:SecurityErrorEvent):void
         {
            (param1.target as Socket).close();
            testEnvironmentAvailable(false);
         });
         socket.addEventListener("ioError",function(param1:IOErrorEvent):void
         {
            (param1.target as Socket).close();
            testEnvironmentAvailable(false);
         });
         socket.connect(host,ports[0]);
      }
      
      private function getEnvironmentNames(param1:Array) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(getEnvironmentName(_loc2_));
         }
         return _loc3_;
      }
      
      public function getEnvironmentName(param1:String) : String
      {
         var _loc3_:String = param1;
         var _loc2_:String = "connection.info.name." + param1;
         if(var_1635.propertyExists(_loc2_))
         {
            _loc3_ = var_1635.getProperty(_loc2_);
         }
         else
         {
            class_21.log("Could not find name for environment: " + param1);
         }
         return _loc3_;
      }
      
      private function dropMenuEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var _loc4_:Array = getAvailableEnvironments();
         var _loc5_:int = var_548.selection;
         var _loc3_:String = _loc4_[_loc5_];
         var_3328 = _loc3_;
         dispatchEvent(new Event("ENVIRONMENT_SELECTED_EVENT"));
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
   }
}

