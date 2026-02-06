package com.sulake.habbo.communication.messages.outgoing.talent
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetTalentTrackLevelMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function GetTalentTrackLevelMessageComposer(param1:String)
      {
         super();
         var_24.push(param1);
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

