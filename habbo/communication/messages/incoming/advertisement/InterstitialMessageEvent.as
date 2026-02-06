package com.sulake.habbo.communication.messages.incoming.advertisement
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.advertisement.InterstitialMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class InterstitialMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function InterstitialMessageEvent(param1:Function)
      {
         super(param1,InterstitialMessageEventParser);
      }
      
      public function getParser() : InterstitialMessageEventParser
      {
         return this.var_15 as InterstitialMessageEventParser;
      }
   }
}

