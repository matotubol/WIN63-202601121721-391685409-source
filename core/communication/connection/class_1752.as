package com.sulake.core.communication.connection
{
   import com.sulake.core.class_23;
   import com.sulake.core.communication.class_43;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageConfiguration;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.communication.messages.IPreEncryptionMessage;
   import com.sulake.core.communication.messages.class_3312;
   import com.sulake.core.communication.wireformat.class_2704;
   import com.sulake.core.communication.wireformat.class_2705;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.ClassUtils;
   import com.sulake.core.utils.ErrorReportStorage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class class_1752 extends EventDispatcherWrapper implements IConnection, class_13
   {
      
      public static const DEFAULT_SOCKET_TIMEOUT:int = 10000;
      
      private var var_93:Socket;
      
      private var var_400:Timer;
      
      private var var_1561:int;
      
      private var var_313:ByteArray;
      
      private var var_2079:class_2704;
      
      private var var_1621:IEncryption;
      
      private var var_2067:IEncryption;
      
      private var var_823:class_3312;
      
      private var _communicationManager:class_43;
      
      private var var_451:class_58;
      
      private var var_3545:Boolean;
      
      private var _configurationReady:Boolean;
      
      private var var_1133:Vector.<IMessageComposer>;
      
      private var var_1671:Vector.<IMessageDataWrapper>;
      
      private var _lastProcessedMessage:IMessageDataWrapper;
      
      public function class_1752(param1:class_43, param2:class_58)
      {
         super();
         _communicationManager = param1;
         var_823 = new class_3312();
         var_2079 = new class_2705();
         createSocket();
         var_400 = new Timer(10000,1);
         var_400.addEventListener("timer",onTimeOutTimer);
         var_451 = param2;
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
      
      public function addListener(param1:String, param2:Function) : void
      {
         addEventListener(param1,param2);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            disposeSocket();
            if(var_400)
            {
               var_400.stop();
               var_400.removeEventListener("timer",onTimeOutTimer);
            }
            var_400 = null;
            var_313 = null;
            var_451 = null;
            var_1621 = null;
            var_2067 = null;
            var_2079 = null;
            if(var_823)
            {
               var_823.dispose();
            }
            var_823 = null;
            _communicationManager = null;
            var_451 = null;
            _lastProcessedMessage = null;
            super.dispose();
         }
      }
      
      public function createSocket() : void
      {
         disposeSocket();
         var_313 = new ByteArray();
         var_2067 = null;
         var_1621 = null;
         var_93 = new Socket();
         var_93.addEventListener("connect",onConnect);
         var_93.addEventListener("complete",onComplete);
         var_93.addEventListener("close",onClose);
         var_93.addEventListener("socketData",onRead);
         var_93.addEventListener("securityError",onSecurityError);
         var_93.addEventListener("ioError",onIOError);
      }
      
      private function disposeSocket() : void
      {
         if(var_93)
         {
            var_93.removeEventListener("connect",onConnect);
            var_93.removeEventListener("complete",onComplete);
            var_93.removeEventListener("close",onClose);
            var_93.removeEventListener("socketData",onRead);
            var_93.removeEventListener("securityError",onSecurityError);
            var_93.removeEventListener("ioError",onIOError);
            if(var_93.connected)
            {
               var_93.close();
            }
            var_93 = null;
         }
      }
      
      [SecureSWF(controlFlow="20",codeWrap="maximum",rename="true",slr="true")]
      public function init(param1:String, param2:uint = 0, param3:Boolean = true) : Boolean
      {
         if(var_451)
         {
            var_451.connectionInit(param1,param2);
         }
         var_400.start();
         var_1561 = getTimer();
         var_93.connect(param1 + (param3 ? "?TCP_NODELAY" : ""),param2);
         return true;
      }
      
      public function set timeout(param1:int) : void
      {
         if(disposed)
         {
            return;
         }
         var_400.delay = param1;
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(disposed)
         {
            return;
         }
         var_823.registerMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(disposed)
         {
            return;
         }
         var_823.unregisterMessageEvent(param1);
      }
      
      public function isAuthenticated() : void
      {
         var_3545 = true;
      }
      
      public function isConfigured() : void
      {
         _configurationReady = true;
         if(var_1671)
         {
            for each(var _loc4_ in var_1671)
            {
               var _loc1_:int = _loc4_.getID();
               var _loc3_:Array = parseReceivedMessage(_loc4_);
            }
         }
         if(var_1133)
         {
            for each(var _loc2_ in var_1133)
            {
               send(_loc2_);
            }
            var_1133 = null;
         }
         var_1133 = new Vector.<IMessageComposer>(0);
         var_1671 = new Vector.<IMessageDataWrapper>(0);
      }
      
      [SecureSWF(controlFlow="20",codeWrap="maximum",rename="true")]
      public function send(param1:IMessageComposer) : Boolean
      {
         if(disposed)
         {
            return false;
         }
         if(var_3545 && !_configurationReady)
         {
            if(var_1133 == null)
            {
               var_1133 = new Vector.<IMessageComposer>(0);
            }
            var_1133.push(param1);
            return false;
         }
         var _loc4_:int = var_823.getMessageIDForComposer(param1);
         if(_loc4_ < 0)
         {
            return false;
         }
         var _loc2_:Array = param1.getMessageArray();
         var _loc3_:ByteArray = var_2079.encode(_loc4_,_loc2_);
         if(var_451)
         {
            var_451.messageSent(String(_loc4_));
         }
         if(var_1621 == null)
         {
            return false;
         }
         if(var_93.connected)
         {
            var_1621.encipher(_loc3_);
            var_93.writeBytes(_loc3_);
            var_93.flush();
            return true;
         }
         return false;
      }
      
      [SecureSWF(controlFlow="20",codeWrap="maximum",rename="true")]
      public function sendUnencrypted(param1:IMessageComposer) : Boolean
      {
         if(disposed)
         {
            return false;
         }
         var _loc4_:int = var_823.getMessageIDForComposer(param1);
         if(_loc4_ < 0)
         {
            return false;
         }
         var _loc2_:Array = param1.getMessageArray();
         var _loc3_:ByteArray = var_2079.encode(_loc4_,_loc2_);
         var _loc6_:String = getQualifiedClassName(param1);
         var _loc5_:Class = getDefinitionByName(_loc6_) as Class;
         if(!ClassUtils.implementsInterface(_loc5_,IPreEncryptionMessage))
         {
            return false;
         }
         if(var_451)
         {
            var_451.messageSent(String(_loc4_));
         }
         if(var_93.connected)
         {
            var_93.writeBytes(_loc3_);
            var_93.flush();
            return true;
         }
         return false;
      }
      
      public function setEncryption(param1:IEncryption, param2:IEncryption) : void
      {
         var_1621 = param1;
         var_2067 = param2;
      }
      
      public function registerMessageClasses(param1:IMessageConfiguration) : void
      {
         var_823.registerMessages(param1);
      }
      
      private function processData() : void
      {
         var _loc1_:Array = null;
         _loc1_ = splitReceivedMessages();
         for each(_lastProcessedMessage in _loc1_)
         {
            var _loc2_:int = _lastProcessedMessage.getID();
            if(var_451)
            {
               var_451.messageReceived(String(0));
            }
            if(var_3545 && !_configurationReady)
            {
               if(var_1671 == null)
               {
                  var_1671 = new Vector.<IMessageDataWrapper>(0);
               }
               var_1671.push(_lastProcessedMessage);
            }
            else
            {
               var _loc3_:Array = parseReceivedMessage(_lastProcessedMessage);
            }
         }
      }
      
      [SecureSWF(controlFlow="0")]
      public function processReceivedData() : void
      {
         if(disposed)
         {
            return;
         }
         try
         {
            processData();
         }
         catch(e:Error)
         {
            if(var_451 && _lastProcessedMessage)
            {
               var_451.messageParseError(_lastProcessedMessage);
            }
            if(!disposed)
            {
               throw e;
            }
         }
      }
      
      private function splitReceivedMessages() : Array
      {
         var _loc1_:ByteArray = null;
         var_313.position = 0;
         if(var_313.bytesAvailable == 0)
         {
            return [];
         }
         var _loc2_:Array = var_2079.splitMessages(var_313,this);
         if(var_313.bytesAvailable == 0)
         {
            var_313 = new ByteArray();
         }
         else if(var_313.position > 0)
         {
            _loc1_ = new ByteArray();
            _loc1_.writeBytes(var_313,var_313.position);
            var_313 = _loc1_;
         }
         return _loc2_;
      }
      
      private function parseReceivedMessage(param1:IMessageDataWrapper) : Array
      {
         var _loc2_:IMessageParser = null;
         var _loc3_:Array = var_823.getMessageEventsForID(param1.getID());
         if(_loc3_ != null)
         {
            _loc2_ = (_loc3_[0] as IMessageEvent).parser;
            try
            {
               _loc2_.flush();
               _loc2_.parse(param1);
            }
            catch(e:Error)
            {
               class_23.crash(getKeyValue([[65220,65192,65183,65179],[65185,65185,65252,65167],[65171,65249,65168,65182],[65164,65162,65175,65243],[65169,65163,65173,65160],[65161,65164,65158,65164],[65234,65156,65163,65148],[65147,65164,65157,65158],[65226,65140,65141,65150,65144,65150]],0) + getQualifiedClassName(_loc2_),e.errorID,e);
            }
         }
         return _loc3_;
      }
      
      private function handleReceivedMessage(param1:int, param2:Array) : void
      {
         for each(var _loc3_ in param2)
         {
            _loc3_.connection = this;
            _loc3_.callback.call(null,_loc3_);
         }
      }
      
      public function get connected() : Boolean
      {
         if(var_93 == null)
         {
            return false;
         }
         return var_93.connected;
      }
      
      public function close() : void
      {
         if(var_93 == null)
         {
            return;
         }
         try
         {
            var_93.close();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onRead(param1:ProgressEvent) : void
      {
         if(var_93 == null)
         {
            return;
         }
         var_313.position = var_313.length;
         var_93.readBytes(var_313,var_313.position);
      }
      
      public function getServerToClientEncryption() : IEncryption
      {
         return var_2067;
      }
      
      private function onConnect(param1:Event) : void
      {
         var_400.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65182],[65182,65249,65175,65169,65246]],0) + (getTimer() - var_1561));
         dispatchEvent(param1);
      }
      
      private function onClose(param1:Event) : void
      {
         var_400.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65223,65181,65177,65172],[65185,65185,65252,65178],[65172,65249]],0) + (getTimer() - var_1561));
         dispatchEvent(param1);
      }
      
      private function onComplete(param1:Event) : void
      {
         var_400.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65223,65178,65179,65175],[65178,65184,65168,65182],[65182,65249,65175,65169,65246]],0) + (getTimer() - var_1561));
         dispatchEvent(param1);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         var_400.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65207,65188,65189,65170],[65172,65180,65168,65162],[65213,65167,65166,65168],[65164,65245,65171,65165,65242]],0) + (getTimer() - var_1561));
         dispatchEvent(param1);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         var_400.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65217,65210,65219,65173],[65172,65174,65170,65251],[65177,65171,65248]],0) + (getTimer() - var_1561));
         switch(param1.type)
         {
            case "ioError":
            case "diskError":
            case "networkError":
            case "verifyError":
         }
         dispatchEvent(param1);
      }
      
      private function onTimeOutTimer(param1:TimerEvent) : void
      {
         var_400.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65206,65184,65179,65186],[65207,65168,65168,65251],[65177,65171,65248,65247]],0) + (getTimer() - var_1561));
         var _loc2_:IOErrorEvent = new IOErrorEvent("ioError");
         _loc2_.text = getKeyValue([[65207,65178,65189,65180],[65185,65169,65252,65199],[65177,65172,65179,65168],[65161,65161,65244,65235]],0) + var_400.delay + getKeyValue([[65258,65180,65173,65246],[65240,65253,65204,65172],[65167,65166,65175,65181],[65170,65176,65244,65205],[65169,65159,65171,65152],[65173,65161,65160,65221]],0);
         dispatchEvent(_loc2_);
      }
   }
}

