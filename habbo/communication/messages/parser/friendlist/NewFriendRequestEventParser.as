package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2254;
   
   [SecureSWF(rename="true")]
   public class NewFriendRequestEventParser implements IMessageParser
   {
      
      private var var_5224:class_2254;
      
      public function NewFriendRequestEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_5224 = new class_2254(param1);
         return true;
      }
      
      public function get req() : class_2254
      {
         return this.var_5224;
      }
   }
}

