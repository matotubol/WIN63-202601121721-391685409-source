package com.sulake.habbo.ui.widget.camera
{
   import flash.display.BitmapData;
   
   public class CameraSlotData
   {
      
      public var image:BitmapData;
      
      private var var_1573:Date;
      
      public var isEmpty:Boolean;
      
      public function CameraSlotData()
      {
         super();
      }
      
      public function setDate(param1:Date) : void
      {
         var_1573 = param1;
      }
      
      public function get dateString() : String
      {
         return var_1573.date + "/" + (var_1573.month + 1) + "/" + var_1573.getFullYear() + " " + var_1573.getHours() + ":" + addLeadingZero(var_1573.getMinutes());
      }
      
      private function addLeadingZero(param1:int) : String
      {
         var _loc2_:String = param1.toString();
         if(_loc2_.length == 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public function getDateTimestamp() : int
      {
         return var_1573.time;
      }
   }
}

