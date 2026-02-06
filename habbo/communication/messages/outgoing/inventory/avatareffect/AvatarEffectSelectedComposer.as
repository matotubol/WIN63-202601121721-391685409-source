package com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectSelectedComposer implements IMessageComposer
   {
      
      private var var_230:int;
      
      public function AvatarEffectSelectedComposer(param1:int)
      {
         super();
         var_230 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_230);
         return _loc1_;
      }
   }
}

