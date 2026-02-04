package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SelectorDefinition extends class_2397
   {
      
      private var var_2872:Boolean;
      
      private var var_3362:Boolean;
      
      public function SelectorDefinition(param1:IMessageDataWrapper)
      {
         super(param1);
      }
      
      override protected function readDefinitionSpecifics(param1:IMessageDataWrapper) : void
      {
         var_2872 = param1.readBoolean();
         var_3362 = param1.readBoolean();
      }
      
      public function set isFilter(param1:Boolean) : void
      {
         var_2872 = param1;
      }
      
      public function set isInvert(param1:Boolean) : void
      {
         var_3362 = param1;
      }
      
      public function get isFilter() : Boolean
      {
         return var_2872;
      }
      
      public function get isInvert() : Boolean
      {
         return var_3362;
      }
   }
}

