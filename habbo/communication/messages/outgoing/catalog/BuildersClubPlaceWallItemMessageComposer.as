package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class BuildersClubPlaceWallItemMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function BuildersClubPlaceWallItemMessageComposer(param1:int, param2:int, param3:String, param4:String, param5:Boolean = false)
      {
         super();
         var_24 = [param1,param2,param3,param4,param5];
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

