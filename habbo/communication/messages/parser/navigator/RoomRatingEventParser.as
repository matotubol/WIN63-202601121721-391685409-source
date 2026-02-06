package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomRatingEventParser implements IMessageParser
   {
      
      private var var_5185:int;
      
      private var var_4229:Boolean;
      
      public function RoomRatingEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_5185 = param1.readInteger();
         this.var_4229 = param1.readBoolean();
         return true;
      }
      
      public function get rating() : int
      {
         return var_5185;
      }
      
      public function get canRate() : Boolean
      {
         return var_4229;
      }
   }
}

