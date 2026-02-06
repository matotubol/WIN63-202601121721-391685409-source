package com.sulake.habbo.communication.messages.incoming.gifts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.gifts.PhoneCollectionStateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PhoneCollectionStateMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PhoneCollectionStateMessageEvent(param1:Function)
      {
         super(param1,PhoneCollectionStateMessageEventParser);
      }
      
      public function getParser() : PhoneCollectionStateMessageEventParser
      {
         return var_15 as PhoneCollectionStateMessageEventParser;
      }
   }
}

