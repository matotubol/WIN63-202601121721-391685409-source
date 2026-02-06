package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class QuestionAnsweredEventParser implements IMessageParser
   {
      
      private var var_1270:int;
      
      private var _value:String;
      
      private var var_2463:class_55;
      
      public function QuestionAnsweredEventParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function get answerCounts() : class_55
      {
         return var_2463;
      }
      
      public function flush() : Boolean
      {
         var_1270 = -1;
         _value = "";
         var_2463 = null;
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         _value = param1.readString();
         var_2463 = new class_55();
         var _loc5_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc5_)
         {
            var _loc4_:String = param1.readString();
            var _loc2_:int = param1.readInteger();
            var_2463.add(null,0);
            _loc3_++;
         }
         return true;
      }
   }
}

