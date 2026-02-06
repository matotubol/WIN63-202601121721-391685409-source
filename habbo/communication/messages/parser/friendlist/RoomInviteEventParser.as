package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomInviteEventParser implements IMessageParser
   {
      
      private var var_1229:int;
      
      private var var_940:String;
      
      public function RoomInviteEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1229 = param1.readInteger();
         this.var_940 = param1.readString();
         return true;
      }
      
      public function get senderId() : int
      {
         return this.var_1229;
      }
      
      public function get messageText() : String
      {
         return this.var_940;
      }
   }
}

