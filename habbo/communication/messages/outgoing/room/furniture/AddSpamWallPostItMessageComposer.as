package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AddSpamWallPostItMessageComposer implements IMessageComposer
   {
      
      private var var_2529:int;
      
      private var var_559:String;
      
      private var var_986:String;
      
      private var var_628:String;
      
      public function AddSpamWallPostItMessageComposer(param1:int, param2:String, param3:String, param4:String)
      {
         super();
         var_2529 = param1;
         var_559 = param2;
         var_986 = param4;
         var_628 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_2529,var_559,var_628,var_986];
      }
   }
}

