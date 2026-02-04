package com.sulake.habbo.roomevents.wired_setup
{
   public class ClipboardWiredEntry
   {
      
      private var _intParams:Array;
      
      private var var_2186:String;
      
      private var var_2226:Array;
      
      private var var_2620:Array;
      
      private var _stuffIds2:Array;
      
      private var var_2655:Array;
      
      private var var_2324:Array;
      
      private var var_3051:int = 0;
      
      private var var_3263:int = 0;
      
      private var var_2872:Boolean = false;
      
      private var var_3362:Boolean = false;
      
      public function ClipboardWiredEntry(param1:Array, param2:String, param3:Array, param4:Array, param5:Array, param6:Array, param7:Array)
      {
         super();
         _intParams = param1;
         var_2186 = param2;
         var_2226 = param3;
         var_2620 = param4;
         _stuffIds2 = param5;
         var_2655 = param6;
         var_2324 = param7;
      }
      
      public function get intParams() : Array
      {
         return _intParams;
      }
      
      public function get stringParam() : String
      {
         return var_2186;
      }
      
      public function get variableIds() : Array
      {
         return var_2226;
      }
      
      public function get stuffIds() : Array
      {
         return var_2620;
      }
      
      public function get stuffIds2() : Array
      {
         return _stuffIds2;
      }
      
      public function get furniSourceTypes() : Array
      {
         return var_2655;
      }
      
      public function get userSourceTypes() : Array
      {
         return var_2324;
      }
      
      public function get delayInPulses() : int
      {
         return var_3051;
      }
      
      public function get quantifierCode() : int
      {
         return var_3263;
      }
      
      public function get isFilter() : Boolean
      {
         return var_2872;
      }
      
      public function get isInvert() : Boolean
      {
         return var_3362;
      }
      
      public function set delayInPulses(param1:int) : void
      {
         var_3051 = param1;
      }
      
      public function set quantifierCode(param1:int) : void
      {
         var_3263 = param1;
      }
      
      public function set isFilter(param1:Boolean) : void
      {
         var_2872 = param1;
      }
      
      public function set isInvert(param1:Boolean) : void
      {
         var_3362 = param1;
      }
   }
}

