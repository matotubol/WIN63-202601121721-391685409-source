package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CanCreateRoomEventEventParser implements IMessageParser
   {
      
      private var var_5262:Boolean;
      
      private var var_2759:int;
      
      public function CanCreateRoomEventEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_5262 = param1.readBoolean();
         this.var_2759 = param1.readInteger();
         return true;
      }
      
      public function get canCreateEvent() : Boolean
      {
         return var_5262;
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
   }
}

