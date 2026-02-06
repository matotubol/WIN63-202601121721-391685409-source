package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PickupObjectMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_3874:int;
      
      private var var_4840:Boolean;
      
      public function PickupObjectMessageComposer(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         var_315 = param1;
         var_3874 = param2;
         var_4840 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:int = 0;
         switch(var_3874 - 10)
         {
            case 0:
               _loc1_ = 2;
               break;
            case 10:
               _loc1_ = 1;
               break;
            default:
               return [];
         }
         return [_loc1_,var_315,var_4840];
      }
   }
}

