package com.sulake.habbo.communication.messages.incoming.gifts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.gifts.TryPhoneNumberResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class TryPhoneNumberResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function TryPhoneNumberResultMessageEvent(param1:Function)
      {
         super(param1,TryPhoneNumberResultMessageEventParser);
      }
      
      public function getParser() : TryPhoneNumberResultMessageEventParser
      {
         return var_15 as TryPhoneNumberResultMessageEventParser;
      }
   }
}

