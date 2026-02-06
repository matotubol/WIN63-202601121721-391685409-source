package com.sulake.habbo.communication.messages.outgoing.newnavigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class NavigatorSetSearchCodeViewModeMessageComposer implements IMessageComposer
   {
      
      private var var_1861:Array = [];
      
      public function NavigatorSetSearchCodeViewModeMessageComposer(param1:String, param2:int)
      {
         super();
         var_1861 = [param1,param2];
      }
      
      public function getMessageArray() : Array
      {
         return var_1861;
      }
      
      public function dispose() : void
      {
         var_1861 = null;
      }
   }
}

