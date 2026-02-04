package com.sulake.habbo.communication
{
   import com.hurlant.math.BigInteger;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.class_23;
   import com.sulake.core.communication.class_43;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.connection.class_58;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.handshake.class_1986;
   import com.sulake.core.communication.messages.IMessageConfiguration;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.habbo.communication.encryption.ArcFour;
   import com.sulake.habbo.communication.encryption.DiffieHellman;
   import com.sulake.iid.IIDCoreCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_31.class_2047;
   
   public class HabboCommunicationManager extends class_17 implements class_57, class_58
   {
      
      private static const DEFAULT_CONNECTION_ATTEMPTS:int = 2;
      
      private var _communication:class_43;
      
      private var var_2613:IMessageConfiguration = new class_1881();
      
      private var var_4342:String = "";
      
      private var var_676:Array = [];
      
      private var var_4890:Boolean = true;
      
      private var var_546:int = -1;
      
      private var var_3521:Timer = new Timer(100,1);
      
      private var var_1368:int = 1;
      
      private var var_189:String = "";
      
      private var var_3858:Boolean = false;
      
      private var var_4675:Boolean = false;
      
      private var _a4:Array = [65191,65178,65178,65177,65185];
      
      private var var_1452:Array = [];
      
      private var var_794:class_2079;
      
      private var var_37:IConnection;
      
      private var var_261:int = 0;
      
      private var _requiresInitialRetryAttempt:Boolean = true;
      
      public function HabboCommunicationManager(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         param1.events.addEventListener("unload",unloading);
      }
      
      private static function getKeyValue(param1:Array, param2:int) : String
      {
         var _loc5_:String = "";
         for each(var _loc3_ in param1)
         {
            for each(var _loc4_ in _loc3_)
            {
               _loc5_ += String.fromCharCode(65290 - _loc4_ + param2--);
            }
         }
         return _loc5_;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDCoreCommunicationManager(),function(param1:class_43):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboConfigurationManager(),null,false,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }])]);
      }
      
      private function onAuthenticated(param1:Event) : void
      {
         var_37.isAuthenticated();
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var_37.isConfigured();
      }
      
      public function disconnect() : void
      {
         if(var_37)
         {
            var_37.close();
         }
      }
      
      public function get connection() : IConnection
      {
         return var_37;
      }
      
      public function get mode() : int
      {
         return 0;
      }
      
      public function set mode(param1:int) : void
      {
         var_261 = param1;
      }
      
      public function get port() : int
      {
         if(var_676.length == 0 || var_546 < 0 || var_546 >= var_676.length)
         {
            return 0;
         }
         return var_676[var_546];
      }
      
      public function get suggestedLoginActions() : Array
      {
         return var_1452;
      }
      
      public function set suggestedLoginActions(param1:Array) : void
      {
         var_1452 = param1;
      }
      
      override protected function initComponent() : void
      {
         context.events.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED",onAuthenticated);
         var_37 = _communication.createConnection(this);
         var_37.registerMessageClasses(var_2613);
         var_37.addListener("ioError",onIOError);
         var_37.addListener("securityError",onSecurityError);
         var_37.addListener("connect",onConnect);
         updateHostParameters();
         if(var_4675)
         {
            nextPort();
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_37)
         {
            var_37.dispose();
            var_37 = null;
         }
         if(var_794)
         {
            var_794.dispose();
            var_794 = null;
         }
         super.dispose();
      }
      
      public function updateHostParameters() : void
      {
         var _loc4_:Array = null;
         var _loc7_:int = 0;
         var _loc10_:Array = [65162,65162,65158,65155];
         var _loc9_:Array = [65234,65174,65168,65175,65165,65229];
         var _loc2_:Array = [65170,65162,65157,65155];
         var _loc1_:Array = [65186,65168,65178,65171,65171];
         var _loc5_:String = getProperty(getKeyValue([_a4,_loc1_,_loc9_,_loc2_],0),null);
         if(_loc5_ == null)
         {
            class_23.crash(getKeyValue([_a4,_loc1_,_loc9_,_loc2_],0),30);
            return;
         }
         _loc4_ = [];
         _loc7_ = 1;
         while(_loc7_ < 5)
         {
            _loc5_ = _loc5_.substring(0,_loc5_.length - _loc7_);
            switch(_loc7_ - 1)
            {
               case 0:
                  _loc4_.push(_a4);
                  break;
               case 1:
                  _loc4_.push(_loc1_);
                  break;
               case 2:
                  _loc4_.push(_loc9_);
                  break;
               case 3:
                  _loc4_.push(_loc10_);
            }
            _loc7_++;
         }
         var _loc6_:String = getProperty(getKeyValue(_loc4_,0),null);
         class_23.crash(getKeyValue([_a4,_loc1_,_loc9_,_loc10_],0),30);
      }
      
      public function renewSocket() : void
      {
         var_1368 = 1;
         _requiresInitialRetryAttempt = true;
         if(var_37 != null)
         {
            var_37.createSocket();
         }
      }
      
      public function initConnection(param1:String) : void
      {
         var _loc2_:String = param1;
         if("habbo" === _loc2_)
         {
            if(var_37 == null)
            {
               class_23.crash("Tried to connect to proxy but connection was null",30);
               return;
            }
            var_4675 = true;
            if(allRequiredDependenciesInjected)
            {
               nextPort();
            }
         }
      }
      
      public function addHabboConnectionMessageEvent(param1:IMessageEvent) : IMessageEvent
      {
         if(var_37)
         {
            var_37.addMessageEvent(param1);
         }
         return param1;
      }
      
      public function removeHabboConnectionMessageEvent(param1:IMessageEvent) : void
      {
         if(var_37)
         {
            var_37.removeMessageEvent(param1);
         }
      }
      
      public function connectionInit(param1:String, param2:int) : void
      {
         ErrorReportStorage.setParameter("host",param1);
         ErrorReportStorage.setParameter("port",String(param2));
      }
      
      public function messageReceived(param1:String) : void
      {
         ErrorReportStorage.setParameter("rece_msg_time",String(new Date().getTime()));
         if(var_189.length > 0)
         {
            var_189 += ",R:" + param1;
         }
         else
         {
            var_189 = "R:" + param1;
         }
         if(var_189.length > 150)
         {
            var_189 = var_189.substring(var_189.length - 150);
         }
      }
      
      public function messageSent(param1:String) : void
      {
         ErrorReportStorage.setParameter("sent_msg_time",String(new Date().getTime()));
         if(var_189.length > 0)
         {
            var_189 += ",S:" + param1;
         }
         else
         {
            var_189 = "S:" + param1;
         }
         if(var_189.length > 150)
         {
            var_189 = var_189.substring(var_189.length - 150);
         }
      }
      
      public function messageParseError(param1:IMessageDataWrapper) : void
      {
         ErrorReportStorage.setParameter("sent_msg_data",(param1 as Object).toString());
         ErrorReportStorage.addDebugData("MESSAGE_QUEUE",var_189);
      }
      
      public function setMessageQueueErrorDebugData() : void
      {
         ErrorReportStorage.addDebugData("MESSAGE_QUEUE",var_189);
      }
      
      public function initializeEncryption() : IEncryption
      {
         return new ArcFour();
      }
      
      public function set tcpNoDelay(param1:Boolean) : void
      {
         var_4890 = param1;
      }
      
      public function initializeKeyExchange(param1:BigInteger, param2:BigInteger) : class_1986
      {
         return new DiffieHellman(param1,param2);
      }
      
      private function nextPort() : void
      {
         if(!var_37)
         {
            return;
         }
         if(var_37.connected)
         {
            return;
         }
         var_546 = var_546 + 1;
         if(var_546 >= var_676.length)
         {
            ErrorReportStorage.addDebugData("ConnectionRetry","Connection attempt " + var_1368);
            var_1368 = var_1368 + 1;
            var _loc1_:int = 2;
            if(var_676.length == 1)
            {
               _loc1_++;
            }
            if(var_1368 > 0)
            {
               if(var_3858)
               {
                  return;
               }
               var_3858 = true;
               class_23.error("Connection failed to host and ports",true,30);
               return;
            }
            var_546 = 0;
         }
         var_37.timeout = var_1368 * 10000;
         var_37.init(var_4342 + getKeyValue([[65244,65185,65191,65189,65188],[65174,65238,65184],[65171,65172]],0),var_676[var_546],var_4890);
         if(_requiresInitialRetryAttempt)
         {
            var_546 = var_546 - 1;
            _requiresInitialRetryAttempt = false;
         }
      }
      
      private function tryNextPort() : void
      {
         var_3521.addEventListener("timer",onTryNextPort);
         var_3521.start();
      }
      
      private function unloading(param1:Event) : void
      {
         if(var_37)
         {
            var_37.send(new class_2047());
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         switch(param1.type)
         {
            case "ioError":
            case "diskError":
            case "networkError":
            case "verifyError":
         }
         ErrorReportStorage.addDebugData("Communication IO Error","IOError " + param1.type + " on connect: " + param1.text + ". Port was " + var_676[var_546]);
         tryNextPort();
      }
      
      private function onConnect(param1:Event) : void
      {
         ErrorReportStorage.addDebugData("Connection","Connected with " + var_1368 + " attempts");
      }
      
      private function onTryNextPort(param1:TimerEvent) : void
      {
         nextPort();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         ErrorReportStorage.addDebugData("Communication Security Error","SecurityError on connect: " + param1.text + ". Port was " + var_676[var_546]);
         tryNextPort();
      }
      
      public function createHabboWebApiSession(param1:class_261, param2:String) : class_2079
      {
         if(var_794 != null)
         {
            resetHabboWebApiSession();
         }
         var _loc3_:HabboWebApiSession = new HabboWebApiSession(param2);
         _loc3_.addListener(param1);
         var_794 = _loc3_;
         events.dispatchEvent(new Event("HABBO_POCKET_SESSION_CREATED"));
         return _loc3_;
      }
      
      public function getHabboWebApiSession() : class_2079
      {
         return var_794;
      }
      
      public function resetHabboWebApiSession() : void
      {
         if(var_794)
         {
            var_794.dispose();
            var_794 = null;
         }
      }
   }
}

