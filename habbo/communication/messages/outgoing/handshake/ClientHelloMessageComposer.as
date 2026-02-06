package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IPreEncryptionMessage;
   import flash.system.Capabilities;
   
   [SecureSWF(rename="true")]
   public class ClientHelloMessageComposer implements IMessageComposer, IPreEncryptionMessage
   {
      
      private var var_5306:String = "FLASH25";
      
      public function ClientHelloMessageComposer()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:int = 0;
         if(Capabilities.os.indexOf("Windows") >= 0)
         {
            _loc1_ = 6;
         }
         else if(Capabilities.os.indexOf("Mac") >= 0)
         {
            _loc1_ = 5;
         }
         else if(Capabilities.os.indexOf("Linux") >= 0)
         {
            _loc1_ = 7;
         }
         return new Array("WIN63-202601121721-391685409",var_5306,_loc1_,4);
      }
   }
}

