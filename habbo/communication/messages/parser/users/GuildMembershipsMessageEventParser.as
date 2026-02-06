package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.class_3489;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipsMessageEventParser implements IMessageParser
   {
      
      private var var_2078:Array = [];
      
      public function GuildMembershipsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2078 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_2078.push(new class_3489(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get guilds() : Array
      {
         return var_2078;
      }
   }
}

