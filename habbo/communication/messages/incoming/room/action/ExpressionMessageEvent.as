package com.sulake.habbo.communication.messages.incoming.room.action
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.action.ExpressionMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ExpressionMessageEvent extends MessageEvent
   {
      
      public function ExpressionMessageEvent(param1:Function)
      {
         super(param1,ExpressionMessageEventParser);
      }
      
      public function getParser() : ExpressionMessageEventParser
      {
         return var_15 as ExpressionMessageEventParser;
      }
   }
}

