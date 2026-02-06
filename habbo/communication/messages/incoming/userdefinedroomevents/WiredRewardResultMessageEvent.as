package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredRewardResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class WiredRewardResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_747:int = 6;
      
      public static const const_450:int = 7;
      
      public function WiredRewardResultMessageEvent(param1:Function)
      {
         super(param1,WiredRewardResultMessageEventParser);
      }
      
      public function getParser() : WiredRewardResultMessageEventParser
      {
         return this.var_15 as WiredRewardResultMessageEventParser;
      }
   }
}

