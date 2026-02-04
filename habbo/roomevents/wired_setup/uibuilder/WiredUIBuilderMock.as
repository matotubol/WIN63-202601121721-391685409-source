package com.sulake.habbo.roomevents.wired_setup.uibuilder
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   
   public class WiredUIBuilderMock extends WiredUIBuilder
   {
      
      public function WiredUIBuilderMock(param1:HabboUserDefinedRoomEvents)
      {
         super(param1,null,"",0,false);
      }
      
      override public function addElements(... rest) : void
      {
         for each(var _loc2_ in rest)
         {
            var_1713.push(_loc2_);
         }
      }
      
      public function get buildingElements() : Array
      {
         return var_1713;
      }
   }
}

