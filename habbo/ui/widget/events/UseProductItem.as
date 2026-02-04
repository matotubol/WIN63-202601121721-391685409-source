package com.sulake.habbo.ui.widget.events
{
   public class UseProductItem
   {
      
      private var var_197:int;
      
      private var var_191:int;
      
      private var _name:String;
      
      private var var_2338:int;
      
      private var var_2190:int;
      
      private var var_4098:int;
      
      private var var_5069:Boolean;
      
      public function UseProductItem(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int = -1, param7:Boolean = false)
      {
         super();
         var_197 = param1;
         var_191 = param2;
         _name = param3;
         var_2338 = param4;
         var_2190 = param5;
         var_4098 = param6;
         var_5069 = param7;
      }
      
      public function dispose() : void
      {
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get requestRoomObjectId() : int
      {
         return var_2338;
      }
      
      public function get targetRoomObjectId() : int
      {
         return var_2190;
      }
      
      public function get requestInventoryStripId() : int
      {
         return var_4098;
      }
      
      public function get replace() : Boolean
      {
         return var_5069;
      }
   }
}

