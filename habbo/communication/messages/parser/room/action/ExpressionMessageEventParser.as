package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ExpressionMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int = 0;
      
      private var var_3120:int = -1;
      
      public function ExpressionMessageEventParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get expressionType() : int
      {
         return var_3120;
      }
      
      public function flush() : Boolean
      {
         var_1270 = 0;
         var_3120 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_1270 = param1.readInteger();
         var_3120 = param1.readInteger();
         return true;
      }
   }
}

