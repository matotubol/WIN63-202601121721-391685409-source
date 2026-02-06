package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomEntryInfoMessageEventParser implements IMessageParser
   {
      
      private var var_4511:int;
      
      private var var_2997:Boolean;
      
      public function RoomEntryInfoMessageEventParser()
      {
         super();
      }
      
      public function get guestRoomId() : int
      {
         return var_4511;
      }
      
      public function get owner() : Boolean
      {
         return var_2997;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4511 = param1.readInteger();
         var_2997 = param1.readBoolean();
         return true;
      }
   }
}

