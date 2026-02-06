package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetYoutubeDisplayPlaylistMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array;
      
      public function SetYoutubeDisplayPlaylistMessageComposer(param1:int, param2:String)
      {
         super();
         var_120 = [param1,param2];
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

