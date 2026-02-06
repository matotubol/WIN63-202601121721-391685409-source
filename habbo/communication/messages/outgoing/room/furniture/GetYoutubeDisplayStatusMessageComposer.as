package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetYoutubeDisplayStatusMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array;
      
      public function GetYoutubeDisplayStatusMessageComposer(param1:int)
      {
         super();
         var_120 = [param1];
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

