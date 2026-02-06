package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildCreatedMessageEventParser implements IMessageParser
   {
      
      private var var_4458:int;
      
      private var _groupId:int;
      
      public function GuildCreatedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4458 = param1.readInteger();
         _groupId = param1.readInteger();
         return true;
      }
      
      public function get baseRoomId() : int
      {
         return var_4458;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
   }
}

