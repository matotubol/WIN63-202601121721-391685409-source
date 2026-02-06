package com.sulake.habbo.communication.messages.incoming.availability
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class LoginFailedHotelClosedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function LoginFailedHotelClosedMessageEvent(param1:Function)
      {
         super(param1,LoginFailedHotelClosedMessageEventParser);
      }
      
      public function getParser() : LoginFailedHotelClosedMessageEventParser
      {
         return var_15 as LoginFailedHotelClosedMessageEventParser;
      }
   }
}

