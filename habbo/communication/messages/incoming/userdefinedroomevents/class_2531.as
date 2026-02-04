package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2531 extends class_2397
   {
      
      private var var_3263:int;
      
      private var var_4099:int;
      
      private var var_3362:Boolean;
      
      public function class_2531(param1:IMessageDataWrapper)
      {
         super(param1);
      }
      
      override protected function readDefinitionSpecifics(param1:IMessageDataWrapper) : void
      {
         var_3263 = param1.readInteger();
      }
      
      override protected function readTypeSpecifics(param1:IMessageDataWrapper) : void
      {
         var_4099 = param1.readByte();
         var_3362 = param1.readBoolean();
      }
      
      public function get quantifierCode() : int
      {
         return var_3263;
      }
      
      public function set quantifierCode(param1:int) : void
      {
         var_3263 = param1;
      }
      
      public function get quantifierType() : int
      {
         return var_4099;
      }
      
      public function get isInvert() : Boolean
      {
         return var_3362;
      }
      
      override public function get usingCustomInputSources() : Boolean
      {
         return super.usingCustomInputSources || quantifierCode != 0;
      }
   }
}

