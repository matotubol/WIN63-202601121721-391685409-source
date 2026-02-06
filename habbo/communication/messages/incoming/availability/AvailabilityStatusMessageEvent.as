package com.sulake.habbo.communication.messages.incoming.availability
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AvailabilityStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AvailabilityStatusMessageEvent(param1:Function)
      {
         super(param1,AvailabilityStatusMessageEventParser);
      }
      
      public function getParser() : AvailabilityStatusMessageEventParser
      {
         return var_15 as AvailabilityStatusMessageEventParser;
      }
   }
}

