package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.MiniMailUnreadCountEventParser;
   
   [SecureSWF(rename="true")]
   public class MiniMailUnreadCountEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MiniMailUnreadCountEvent(param1:Function)
      {
         super(param1,MiniMailUnreadCountEventParser);
      }
      
      public function getParser() : MiniMailUnreadCountEventParser
      {
         return var_15 as MiniMailUnreadCountEventParser;
      }
   }
}

