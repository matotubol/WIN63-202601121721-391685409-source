package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.BlockUserUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class BlockUserUpdateMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_664:int = 0;
      
      public static const const_609:int = 1;
      
      public function BlockUserUpdateMessageEvent(param1:Function)
      {
         super(param1,BlockUserUpdateMessageEventParser);
      }
      
      public function get result() : int
      {
         return (var_15 as BlockUserUpdateMessageEventParser).result;
      }
      
      public function get userId() : int
      {
         return (var_15 as BlockUserUpdateMessageEventParser).userId;
      }
   }
}

