package com.sulake.habbo.roomevents.wired_setup.uibuilder
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FramePreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class WiredUIBuilder
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_64:WiredStyle;
      
      private var var_182:PresetManager;
      
      private var var_2595:Function;
      
      private var _holderKey:String;
      
      private var var_3602:int;
      
      private var _frame:FramePreset;
      
      protected var var_1713:Array;
      
      private var var_5103:Boolean;
      
      public function WiredUIBuilder(param1:HabboUserDefinedRoomEvents, param2:Function, param3:String, param4:int, param5:Boolean = false)
      {
         super();
         _roomEvents = param1;
         var_64 = _roomEvents.wiredCtrl.wiredStyle;
         var_182 = _roomEvents.wiredCtrl.presetManager;
         var_2595 = param2;
         var_5103 = param5;
         _holderKey = param3;
         var_3602 = param4;
         var_1713 = [];
      }
      
      public function addElements(... rest) : void
      {
         for each(var _loc2_ in rest)
         {
            var_1713.push(_loc2_);
         }
      }
      
      public function get frame() : FramePreset
      {
         return _frame;
      }
      
      public function build(param1:Number = 1) : void
      {
         _frame = var_182.createFramePreset(var_1713,var_2595,_holderKey,var_3602,var_5103);
         var_1713 = null;
         _frame.resizeToWidth(_frame.window.width * param1);
      }
   }
}

