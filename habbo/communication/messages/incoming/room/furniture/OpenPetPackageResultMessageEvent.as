package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class OpenPetPackageResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function OpenPetPackageResultMessageEvent(param1:Function)
      {
         super(param1,OpenPetPackageResultMessageEventParser);
      }
      
      public function getParser() : OpenPetPackageResultMessageEventParser
      {
         return var_15 as OpenPetPackageResultMessageEventParser;
      }
   }
}

