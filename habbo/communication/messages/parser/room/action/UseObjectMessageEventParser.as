package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UseObjectMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int = 0;
      
      private var var_757:int;
      
      public function UseObjectMessageEventParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get itemType() : int
      {
         return var_757;
      }
      
      public function flush() : Boolean
      {
         var_1270 = 0;
         var_757 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_1270 = param1.readInteger();
         var_757 = param1.readInteger();
         return true;
      }
   }
}

