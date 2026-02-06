package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetAreaHideDataComposer implements IMessageComposer
   {
      
      private var var_2536:int;
      
      private var var_1509:int;
      
      private var var_1754:int;
      
      private var _width:int;
      
      private var _length:int;
      
      private var var_4199:Boolean;
      
      private var var_4770:Boolean;
      
      private var var_4463:Boolean;
      
      public function SetAreaHideDataComposer(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean, param7:Boolean, param8:Boolean)
      {
         super();
         var_2536 = param1;
         var_1509 = param2;
         var_1754 = param3;
         _width = param4;
         _length = param5;
         var_4199 = param6;
         var_4770 = param7;
         var_4463 = param8;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2536,var_1509,var_1754,_width,_length,var_4199,var_4770,var_4463];
      }
      
      public function dispose() : void
      {
      }
   }
}

