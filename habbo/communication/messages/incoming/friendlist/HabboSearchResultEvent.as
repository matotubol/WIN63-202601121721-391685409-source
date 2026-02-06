package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.HabboSearchResultEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboSearchResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboSearchResultEvent(param1:Function)
      {
         super(param1,HabboSearchResultEventParser);
      }
      
      public function getParser() : HabboSearchResultEventParser
      {
         return this.var_15 as HabboSearchResultEventParser;
      }
   }
}

