package com.sulake.habbo.communication.messages.outgoing.newnavigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class NavigatorRemoveCollapsedCategoryMessageComposer implements IMessageComposer
   {
      
      private var var_1861:Array = [];
      
      public function NavigatorRemoveCollapsedCategoryMessageComposer(param1:String)
      {
         super();
         var_1861.push(param1);
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

