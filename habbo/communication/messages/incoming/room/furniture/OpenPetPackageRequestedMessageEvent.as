package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageRequestedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class OpenPetPackageRequestedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function OpenPetPackageRequestedMessageEvent(param1:Function)
      {
         super(param1,OpenPetPackageRequestedMessageEventParser);
      }
      
      public function getParser() : OpenPetPackageRequestedMessageEventParser
      {
         return var_15 as OpenPetPackageRequestedMessageEventParser;
      }
   }
}

