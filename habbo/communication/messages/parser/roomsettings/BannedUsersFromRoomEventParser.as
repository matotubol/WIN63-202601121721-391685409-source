package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3550;
   
   [SecureSWF(rename="true")]
   public class BannedUsersFromRoomEventParser implements IMessageParser
   {
      
      private var var_1951:int;
      
      private var var_3601:Array;
      
      public function BannedUsersFromRoomEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3601 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1951 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_3601.push(new class_3550(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get bannedUsers() : Array
      {
         return var_3601;
      }
   }
}

