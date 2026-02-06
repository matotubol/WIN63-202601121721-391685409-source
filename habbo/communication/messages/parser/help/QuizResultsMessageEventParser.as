package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class QuizResultsMessageEventParser implements IMessageParser
   {
      
      private var var_1366:String;
      
      private var _questionIdsForWrongAnswers:Array;
      
      public function QuizResultsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1366 = null;
         _questionIdsForWrongAnswers = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1366 = param1.readString();
         _questionIdsForWrongAnswers = [];
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            _questionIdsForWrongAnswers.push(param1.readInteger());
            _loc2_++;
         }
         return true;
      }
      
      public function get quizCode() : String
      {
         return var_1366;
      }
      
      public function get questionIdsForWrongAnswers() : Array
      {
         return _questionIdsForWrongAnswers;
      }
   }
}

