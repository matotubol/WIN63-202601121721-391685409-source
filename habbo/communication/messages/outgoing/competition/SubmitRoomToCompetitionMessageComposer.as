package com.sulake.habbo.communication.messages.outgoing.competition
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SubmitRoomToCompetitionMessageComposer implements IMessageComposer
   {
      
      public static const const_757:int = 0;
      
      public static const const_568:int = 1;
      
      public static const const_956:int = 2;
      
      public static const const_1025:int = 3;
      
      private var var_24:Array = [];
      
      public function SubmitRoomToCompetitionMessageComposer(param1:String, param2:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
   }
}

