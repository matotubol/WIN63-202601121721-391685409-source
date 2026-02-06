package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FavoriteMembershipUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_3915:int;
      
      private var var_4216:int;
      
      private var _status:int;
      
      private var _habboGroupName:String;
      
      public function FavoriteMembershipUpdateMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3915 = param1.readInteger();
         var_4216 = param1.readInteger();
         _status = param1.readInteger();
         _habboGroupName = param1.readString();
         return true;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get habboGroupId() : int
      {
         return var_4216;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get habboGroupName() : String
      {
         return _habboGroupName;
      }
   }
}

