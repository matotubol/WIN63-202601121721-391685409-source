package com.sulake.habbo.communication.messages.outgoing.newnavigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class NewNavigatorSearchComposer implements IMessageComposer
   {
      
      private var var_1861:Array = [];
      
      public function NewNavigatorSearchComposer(param1:String, param2:String)
      {
         super();
         var_1861.push(param1);
         var_1861.push(param2);
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

