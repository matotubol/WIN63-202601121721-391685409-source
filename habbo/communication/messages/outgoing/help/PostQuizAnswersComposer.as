package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PostQuizAnswersComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function PostQuizAnswersComposer(param1:String, param2:Array)
      {
         super();
         var_120.push(param1);
         var_120.push(param2.length);
         var _loc3_:int = 0;
         while(0 < param2.length)
         {
            var_120.push(param2[0]);
            _loc3_++;
         }
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
      
      public function dispose() : void
      {
         var_120 = null;
      }
   }
}

