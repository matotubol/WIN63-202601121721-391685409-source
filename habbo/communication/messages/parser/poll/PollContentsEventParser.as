package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PollContentsEventParser implements IMessageParser
   {
      
      private var var_197:int = -1;
      
      private var _startMessage:String = "";
      
      private var _endMessage:String = "";
      
      private var var_2528:int = 0;
      
      private var _questionArray:Array = null;
      
      private var var_3036:Boolean = false;
      
      public function PollContentsEventParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get startMessage() : String
      {
         return _startMessage;
      }
      
      public function get endMessage() : String
      {
         return _endMessage;
      }
      
      public function get numQuestions() : int
      {
         return var_2528;
      }
      
      public function get questionArray() : Array
      {
         return _questionArray;
      }
      
      public function get npsPoll() : Boolean
      {
         return var_3036;
      }
      
      public function flush() : Boolean
      {
         var_197 = -1;
         _startMessage = "";
         _endMessage = "";
         var_2528 = 0;
         _questionArray = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_197 = param1.readInteger();
         _startMessage = param1.readString();
         _endMessage = param1.readString();
         var_2528 = param1.readInteger();
         _questionArray = [];
         var _loc2_:int = 0;
         while(0 < var_2528)
         {
            var _loc4_:class_3757 = parseQuestion(param1);
            var _loc5_:int = param1.readInteger();
            var _loc3_:int = 0;
            _questionArray.push(null);
            _loc2_++;
         }
         var_3036 = param1.readBoolean();
         return true;
      }
      
      private function parseQuestion(param1:IMessageDataWrapper) : class_3757
      {
         var _loc2_:int = 0;
         var _loc3_:class_3757 = new class_3757();
         _loc3_.questionId = param1.readInteger();
         _loc3_.sortOrder = param1.readInteger();
         _loc3_.questionType = param1.readInteger();
         _loc3_.questionText = param1.readString();
         _loc3_.questionCategory = param1.readInteger();
         _loc3_.questionAnswerType = param1.readInteger();
         _loc3_.questionAnswerCount = param1.readInteger();
         if(_loc3_.questionType == 1 || _loc3_.questionType == 2)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.questionAnswerCount)
            {
               _loc3_.questionChoices.push(new class_3851(param1.readString(),param1.readString(),param1.readInteger()));
               _loc2_++;
            }
         }
         return _loc3_;
      }
   }
}

