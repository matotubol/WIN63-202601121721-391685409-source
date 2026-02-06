package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class QuizDataMessageEventParser implements IMessageParser
   {
      
      private var var_1366:String;
      
      private var var_1965:Array;
      
      public function QuizDataMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1366 = null;
         var_1965 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1366 = param1.readString();
         var_1965 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1965.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get quizCode() : String
      {
         return var_1366;
      }
      
      public function get questionIds() : Array
      {
         return var_1965;
      }
   }
}

