package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PlaceObjectMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_3874:int;
      
      private var var_3429:String;
      
      private var var_25:int = 0;
      
      private var var_26:int = 0;
      
      private var var_772:int = 0;
      
      public function PlaceObjectMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int)
      {
         super();
         var_315 = param1;
         var_3874 = param2;
         var_3429 = param3;
         var_25 = param4;
         var_26 = param5;
         var_772 = param6;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         switch(var_3874 - 10)
         {
            case 0:
               return [var_315 + " " + var_25 + " " + var_26 + " " + var_772];
            case 10:
               return [var_315 + " " + var_3429];
            default:
               return [];
         }
      }
   }
}

