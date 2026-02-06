package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildMemberFurniCountInHQMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int;
      
      private var var_4175:int;
      
      public function GuildMemberFurniCountInHQMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         var_4175 = param1.readInteger();
         return true;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get furniCount() : int
      {
         return var_4175;
      }
   }
}

